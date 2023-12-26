# frozen_string_literal: true

module ExactOnline
  module Token
    class Refresher
      attr_accessor :token, :logger, :token_store

      @mutex = Mutex.new

      class << self
        attr_accessor :mutex

        def refresh!(token, token_store, logger = Rails.logger)
          mutex.synchronize do
            new(token, token_store, logger).refresh!
          end
        end
      end

      def initialize(token, token_store, logger = Rails.logger)
        @token = token
        @logger = logger
        @token_store = token_store
        @retries = 0
      end

      def refresh!
        logger.info('Refreshing Exact Online token')
        update_saved_token(token.refresh!)
      rescue StandardError => e
        logger.error("Failed to refresh token: #{e.message}")
        @retries += 1
        sleep(1)
        logger.info("Retrying token refresh for the #{@retries} time")
        refresh! unless @retries > 10
      end

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
    end
  end
end
