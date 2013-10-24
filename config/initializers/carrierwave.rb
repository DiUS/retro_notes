CarrierWave.configure do |config|

  config.storage :fog

  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => Rails.application.config.aws_access_key_id,
    :aws_secret_access_key  => Rails.application.config.aws_secret_access_key
    # :region                 => 'eu-west-1'
  }

  config.fog_directory = Rails.application.config.aws_bucket_name
  # config.fog_public = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

FOG_STORAGE ||= Fog::Storage.new({
    :provider               => 'AWS',
    :aws_access_key_id      => Rails.application.config.aws_access_key_id,
    :aws_secret_access_key  => Rails.application.config.aws_secret_access_key
})