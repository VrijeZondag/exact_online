# frozen_string_literal: true

module ExactOnline
  class Client
    attr_reader :token_store, :config, :token_manager, :oauth_handler

    delegate :token, :token_valid?, to: :token_manager
    delegate :authorize_url, :receive_code, :load_token, to: :oauth_handler
    delegate :get, :post, to: :token

    def self.division
      ExactOnline.configuration.division || (raise 'No division found')
    end

    def initialize(config = ExactOnline.configuration, omit_api_suffix: false)
      @config = config
      @token_store = Object.const_get(ExactOnline.configuration.token_store)
      @oauth_handler = ::ExactOnline::OAuthHandler.new(self, omit_api_suffix:)
      @token_manager = Token::Manager.new(self, oauth_handler.oauth_client)
    end

    def division
      @division ||= config.division
    end

    def base_url
      @base_url ||= "v1/#{division}/"
    end

    def alive?
      token_valid?
    end

    private

    def oauth_site_url
      "#{config.site}#{omit_api_suffix ? '' : 'api'}"
    end
  end
end
