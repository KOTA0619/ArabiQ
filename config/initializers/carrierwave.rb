if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      providor: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION'],
      path_style: true
    }
    config.fog_directory = 'arabiq-image'
  end
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/