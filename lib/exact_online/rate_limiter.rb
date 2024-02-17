# frozen_string_literal: true

module ExactOnline
  class RateLimiter
    def initialize(limit, period)
      @limit = limit
      @period = period
      @timestamps = []
    end

    def allow_request?
      now = Time.now
      @timestamps.reject! { |timestamp| now - timestamp > @period }
      if @timestamps.count < @limit
        @timestamps.push(now)
        Rails.logger.debug("Rate limit not reached, #{@timestamps.count} of #{@limit} requests")
        true
      else
        Rails.logger.info("Rate limit reached, waiting for #{@timestamps.first + @period - now} seconds")
        false
      end
    end

    def wait_for_request
      sleep(@period - (Time.now - @timestamps.first)) until allow_request?
    end
  end
end
