# frozen_string_literal: true

module Public
  module ExactOnline
    class CustomersController < Base
      skip_before_action :verify_authenticity_token

      def webhook
        render status: :ok, json: { status: :ok }
      end
    end
  end
end
