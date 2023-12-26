# frozen_string_literal: true

module ExactOnline
  class Configuration
    REQUIRED_PARAMS = %i[client_id client_secret division auth_webhook_url].freeze
    DEFAULTS = {
      division: nil,
      auth_webhook_url: nil,
      client_id: nil,
      client_secret: nil,
      site: 'https://start.exactonline.nl/',
      authorize_url: 'oauth2/auth',
      token_url: 'oauth2/token',
      token_store: 'Api::Token'
    }.freeze

    attr_accessor(*DEFAULTS.keys)

    private_constant :DEFAULTS, :REQUIRED_PARAMS

    def initialize(&)
      set_defaults
      apply_custom_configurations(&)
      # check_required_parameters
    end

    private

    def set_defaults
      DEFAULTS.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def apply_custom_configurations
      yield(self) if block_given?
    end

    def check_required_parameters
      missing_params = REQUIRED_PARAMS.select { |param| send(param).nil? }
      return if missing_params.empty?

      raise MissingConfigurationError, MissingConfigurationError.format_message(missing_params)
    end

    class MissingConfigurationError < StandardError
      def self.format_message(missing_params)
        "Missing required parameters: #{missing_params.join(', ')}"
      end
    end
  end
end
