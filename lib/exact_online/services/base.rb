# frozen_string_literal: true

module ExactOnline
  module Services
    class Base
      def initialize(client = Client.new)
        @client = client
      end

      def base_url
        @base_url ||= "v1/#{division}/"
      end

      def client
        @client ||= Client.new
      end

      def division
        @division ||= client.division
      end

      private

      def parse_response(response)
        result = Hash.from_xml(response).dig('feed', 'entry')
        if result.is_a?(Hash)
          [result]
        else
          result
        end
      end
    end
  end
end

require 'exact_online/services/customers_api'
require 'exact_online/services/purchase_invoices_api'
