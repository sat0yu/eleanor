class CreateSpeechWorker
  include Sidekiq::Worker

  def perform(script_id)
    script = Script.eager_load(:speech).find(snippet_id)
    return if script.speech.present?
  end
end
