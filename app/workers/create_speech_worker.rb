class CreateSpeechWorker
  include Sidekiq::Worker

  SCRIPT_MAX_SIZE = 1500.freeze
  WAIT_DURATION = 1.freeze

  attr_reader :script_id, :region, :voice_id

  def perform(script_id, region: 'ap-northeast-1', voice_id: 'Mizuki')
    @script_id = script_id
    @region    = region
    @voice_id  = voice_id

    file_path = synthesize_speech
    object = upload_s3(file_path)
    remove_files("#{file_path}*")

    ActiveRecord::Base.transaction do
      Speech.create!(script_id: script.id, url: object.public_url, size: object.content_length)
      script.touch
    end
  end

  def synthesize_speech
    chunks.each.with_index do |chunk, idx|
      file_name = "#{dir_path}/#{base_file_name}.#{idx}"
      synthesize(file_name: file_name, text: chunk)
      sleep(WAIT_DURATION)
    end
    combine_partials
  end

  def upload_s3(file_path)
    object = s3.bucket(bucket_name).object(file_path.split("/").last)
    raise 'failed upload' unless object.upload_file(file_path, acl:'public-read')
    object
  end

  private

  def bucket_name
    @bucket_name ||= Rails.application.config.s3_bucket_for_speech
  end

  def chunks
    @chunks ||= script.body.chars.each_slice(SCRIPT_MAX_SIZE).map(&:join)
  end

  def combine_partials
    output_file = "#{dir_path}/#{base_file_name}"
    `cat #{dir_path}/#{base_file_name}.* > #{output_file}`
    output_file
  end

  def remove_files(file_path)
    `rm -rf #{file_path}`
  end

  def dir_path
    @dir_path ||= "./tmp"
  end

  def base_file_name
    @base_file_name ||= "script_#{script_id}.mp3"
  end

  def synthesize(file_name:, text:)
    raise 'too long text' if text.size > SCRIPT_MAX_SIZE
    polly.synthesize_speech(
      response_target: file_name,
      text:            text,
      voice_id:        voice_id,
      output_format:   'mp3',
    )
  end

  def script
    @script ||= begin
      script = Script.eager_load(:speech).find(script_id)
      raise 'already a speec exists' if script.speech.present?
      script
    end
  end

  def polly
    @polly ||= Aws::Polly::Client.new(region: region)
  end

  def s3
    @s3 ||= Aws::S3::Resource.new(region: region)
  end
end
