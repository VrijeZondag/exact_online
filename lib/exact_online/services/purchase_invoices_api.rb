# frozen_string_literal: true

module ExactOnline
  module Services
    class PurchaseInvoicesApi < Base
      RESOURCE = "purchaseentry/PurchaseEntries"

      class << self
        delegate :find, to: :new
      end

      def find(id)
        url = "#{base_url}#{RESOURCE}(guid'#{id}')"
        response = client.get(url).response.body
        parse_response(response)
      end

      def parse_response(response)
        Hash.from_xml(response).dig("entry", "content")
      end
    end
  end
end
