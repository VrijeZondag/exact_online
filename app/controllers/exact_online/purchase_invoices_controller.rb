# frozen_string_literal: true

module Public
  module ExactOnline
    class PurchaseInvoicesController < Base
      skip_before_action :verify_authenticity_token

      def webhook
        ::ExactOnline::Jobs::CreatePurchaseInvoice.perform_now(params[:Content][:Key]) if params.dig(:Content,
                                                                                                     :Key).present?

        render status: :ok, json: { status: :ok }
      end
    end
  end
end
