# frozen_string_literal: true

module ExactOnline
  module Resources
    class PurchaseInvoiceLines < Base
      @service = Services::PurchaseInvoiceLinesApi
      CONTENT_PROPERTIES_KEY = %w[content properties].freeze

      attr_reader :description, :amount, :gl_account_code

      class << self
        def get_from_invoice(id)
          response = @service.where(EntryID: "guid'#{id}'")
          Collection.new(response.map { |item| new(item) })
        end
      end

      def initialize(item)
        properties = item.dig(*CONTENT_PROPERTIES_KEY)
        @description = properties['Description']
        @amount = properties['VATBaseAmountDC'].to_d if properties['VATBaseAmountDC']
        @gl_account_code = properties['GLAccountCode']
      end
    end
  end
end

## FOR TESTING
## ExactOnline::Resources::PurchaseInvoiceLines.get_from_invoice("f0e209a3-e7de-4852-adaf-fde94d269a66")
