Raven.configure do |config|
  config.environments = %w[ production staging ]
  if Rails.env.production? || Rails.env.staging?
    raise NotImplementedError unless config.dsn = Rails.application.config.raven_dsn
    config.sanitize_fields = %w[ password ]
  end
end
