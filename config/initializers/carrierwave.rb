CarrierWave.configure do |config|

  if Rails.env.test?
    config.enable_processing = false
  end

  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV["aws_access_key_id"],
      aws_secret_access_key: ENV["aws_secret_access_key"],
      region:                ENV["aws_region"],
    }
    config.fog_directory  = 'odinsy'
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end

end
