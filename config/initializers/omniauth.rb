Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '0H2YAiTrwzVFdY2qoVpA', '3qfGL5sbtWCuSx4UWwSo3hzQ63JHG3fuFmGLGlY'
  provider :facebook, '155210894572578', 'a92c057df6a4988b3615b379c89d8580'
end
