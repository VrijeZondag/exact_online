# frozen_string_literal: true

def exact_online_config
  ExactOnline::Configuration.new do |c|
    app_url = Rails.configuration.action_mailer.default_url_options[:host]
    ## Required params:
    c.division = 1_234_567 ## Replace with your own division
    c.auth_webhook_url = "#{app_url}/exact_online/authentication/webhook"
    c.client_id = Rails.application.credentials.dig(:exact_online, :live, :client_id) ## Requires credentials
    c.client_secret = Rails.application.credentials.dig(:exact_online, :live, :client_secret) ## Requires credentials

    ## Below shouldn't be changed:
    # c.site = "https://start.exactonline.nl/"
    # c.authorize_url = "oauth2/auth"
    # c.token_url = "oauth2/token"
  end
end
