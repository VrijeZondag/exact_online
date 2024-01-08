# frozen_string_literal: true

require 'oauth2'

module ExactOnline
  class OAuthHandler
    attr_reader :config, :omit_api_suffix, :client

    def initialize(client, omit_api_suffix: false)
      @client = client
      @config = client.config
      @omit_api_suffix = omit_api_suffix
    end

    def authorize_url
      oauth_client.auth_code.authorize_url(redirect_uri: config.auth_webhook_url)
    end

    def receive_code(code)
      result = oauth_client.auth_code.get_token(code, redirect_uri: config.auth_webhook_url)
      client.token_manager.update_saved_token(result)
    rescue StandardError => e
      Rails.logger.error("Error when receiving Code: #{e.message}")
    end

    def oauth_client
      @oauth_client ||= new_client
    end

    def load_token(hashed_token)
      OAuth2::AccessToken.from_hash(new_client, hashed_token)
    end

    private

    def new_client
      OAuth2::Client.new(
        config.client_id,
        config.client_secret,
        site: oauth_site_url,
        authorize_url: config.authorize_url,
        token_url: config.token_url
      )
    end

    def oauth_site_url
      "#{config.site}#{omit_api_suffix ? '' : 'api'}"
    end
  end
end
