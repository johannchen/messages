Rails.application.config.middleware.use OmniAuth::Builder do
  # you need a store for OpenID; (if you deploy on heroku you need Filesystem.new('./tmp') instead of Filesystem.new('/tmp'))

  require 'omniauth-openid'
  require 'openid/store/filesystem'
  #require 'omniauth-facebook'

   provider :open_id, store: OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
   #provider :facebook, '155210894572578', 'a92c057df6a4988b3615b379c89d8580', :scope => 'email'
end
