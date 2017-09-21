OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '133423560727660', '45bde1085e118951d8ad27e6b7449fb2'
  provider :google_oauth2, '417271723796-bu8s32f3gbikpsq5ebg8n2on83n2i3ab.apps.googleusercontent.com', 'uNHhF2HkTAMMbUtvQfKQ7DyF', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
