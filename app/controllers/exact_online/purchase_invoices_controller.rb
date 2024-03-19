# frozen_string_literal: true

module ExactOnline
  class PurchaseInvoicesController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def webhook
      ::ExactOnline::Jobs::CreatePurchaseInvoice.perform_later(params[:Content][:Key]) if params.dig(:Content,
                                                                                                   :Key).present?

      render status: :ok, json: { status: :ok }
    end
  end
end
