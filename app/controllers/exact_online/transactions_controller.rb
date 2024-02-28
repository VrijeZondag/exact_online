# frozen_string_literal: true

module ExactOnline
  class TransactionsController < ActionController::Base
    def webhook
      Rails.logger.info "Exact Online webhook received: #{params.inspect}"

      render status: :ok, json: { status: :ok }
    end
  end
end
