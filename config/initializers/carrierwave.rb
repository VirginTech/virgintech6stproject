CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => Rails.application.secrets.aws_access_key_id ,
      :aws_secret_access_key  => Rails.application.secrets.aws_secret_access_key ,
      :region                 => 'ap-northeast-1',
      :path_style             => true
  }
  
  config.storage = :fog
  config.cache_storage = :fog
  config.cache_dir = "cache"

  config.fog_public     = true
  config.fog_attributes = {'Cache-Control' => 'public, max-age = 365.day.to_i'}
  
  case Rails.env
    when 'development'
      config.fog_directory = 'virgintech.6st.dev'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/virgintech.6st.dev'
    when 'production'
      config.fog_directory = 'virgintech.6st.pro'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/virgintech.6st.pro'
  end

end