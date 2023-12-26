# frozen_string_literal: true

ExactOnline.configure do |c|
  ## Required params:
  app_url = Rails.configuration.action_mailer.default_url_options[:host]
  c.division = 1_234_567
  c.auth_webhook_url = "#{app_url}/exact_online/authentication/webhook"
  c.client_id = Rails.application.credentials.dig(:exact_online, :live, :client_id)
  c.client_secret = Rails.application.credentials.dig(:exact_online, :live, :client_secret)
  ## Below shouldn't be changed:
  # c.site = "https://start.exactonline.nl/"
  # c.authorize_url = "oauth2/auth"
  # c.token_url = "oauth2/token"
end
