Aws.config.update({
  credentials: Aws::Credentials.new(
    Rails.application.secrets.aws_access_key_id,
    Rails.application.secrets.aws_secret_access_key
  ),
  region: 'ap-northeast-1',
  log_level: :debug,
})
