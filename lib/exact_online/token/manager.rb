# frozen_string_literal: true

module ExactOnline
  module Token
    class Manager
      attr_reader :token_store, :config, :oauth_client, :client

      @mutex = Mutex.new
      class << self
        attr_reader :mutex
      end

      def initialize(client, oauth_client)
        @oauth_client = oauth_client
        @client = client
        @token_store = client.token_store
        @config = client.config
      end

      def token
        self.class.mutex.synchronize do
          renew_token_if_expired
          current_token
        end
      end

      def token_valid?
        return false unless token.expires_at > Time.current.to_i

        true
      rescue StandardError => e
        Rails.logger.error("Failed to validate token: #{e.message}")
        false
      end

      ## dont love the duplication with the token refresher
      def update_saved_token(token)
        token_store.find_or_create_by(app: :exact_online).update(
          token: token.token,
          refresh_token: token.refresh_token,
          expires_in: token.expires_in,
          hashed_token: token.to_hash,
          locked: false
        )
        logger.info('New Exact Online token saved')
      end

      private

      def renew_token_if_expired
        return unless current_token&.expired?

        log_info('Exact Online token expired, refreshing')
        renew_token
      rescue StandardError => e
        Rails.logger.error("Failed to refresh token: #{e.message}")
        token_store.find_or_create_by(app: :exact_online).update(locked: false)
      end

      def renew_token
        Refresher.refresh!(current_token, token_store)
        clear_cached_tokens
      end

      def current_token
        @current_token ||= client.load_token(stored_token.hashed_token)
      end

      def stored_token
        @stored_token ||= token_store.find_or_create_by(app: :exact_online)
      end

      def clear_cached_tokens
        @stored_token = nil
        @current_token = nil
      end

      def log_info(message)
        Rails.logger.info(message)
      end
    end
  end
end
