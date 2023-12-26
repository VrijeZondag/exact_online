# frozen_string_literal: true

module ExactOnline
  class CustomersController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def webhook
      render status: :ok, json: { status: :ok }
    end
  end
end
