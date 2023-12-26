# frozen_string_literal: true

module ExactOnline
  module Resources
    class PurchaseInvoiceLines < Base
      INVOICE_LINES_PATH      = 'purchaseentry/PurchaseEntryLines'
      FILTER_PARAM            = "?$filter=EntryID eq guid'%s'"
      SELECT_PARAMS           = '&$select=AmountDC,Description,GLAccountCode,VATBaseAmountDC'
      CONTENT_PROPERTIES_KEY  = %w[content properties].freeze

      attr_reader :description, :amount, :gl_account_code

      class << self
        def get_from_invoice(id)
          request = client.token.get(invoice_url(id)).response
          return nil unless request.success?

          parsed_response = Hash.from_xml(request.body)

          collection = transform_response_to_invoice_lines(parsed_response)
          Collection.new(collection)
        end

        def invoice_url(id)
          [base_url, INVOICE_LINES_PATH, FILTER_PARAM % id, SELECT_PARAMS].join
        end

        def transform_response_to_invoice_lines(parsed_response)
          entries = Array.wrap(parsed_response.dig('feed', 'entry'))
          entries.map { |item| new(item) }
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
## Api::ExactOnline::Resources::PurchaseInvoiceLines.get_from_invoice("f0e209a3-e7de-4852-adaf-fde94d269a66")
