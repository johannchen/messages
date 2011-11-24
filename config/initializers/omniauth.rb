Rails.application.config.middleware.use OmniAuth::Builder do
  # you need a store for OpenID; (if you deploy on heroku you need Filesystem.new('./tmp') instead of Filesystem.new('/tmp'))

  require 'omniauth-openid'
  require 'openid/store/filesystem'
  require 'omniauth-facebook'

#  provider :twitter, '0H2YAiTrwzVFdY2qoVpA', '3qfGL5sbtWCuSx4UWwSo3hzQ63JHG3fuFmGLGlY'
  
   provider :open_id, store: OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
   provider :facebook, '247837025275647', '1097e8f5efb85a12813ec40d6387d0ad', :scope => 'email'
end
