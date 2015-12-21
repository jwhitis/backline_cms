CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              "AWS",
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
  config.fog_directory = ENV['AWS_BUCKET']
  config.fog_use_ssl_for_aws = false # Bucket names containing periods do not work with SSL
end