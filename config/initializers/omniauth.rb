Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook,      ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :facebook, '260852514258091', 'a7044f1447adf48ce486f9822bddf3e7'
end
