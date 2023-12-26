# frozen_string_literal: true

module ExactOnline
  module Resources
    class Base
      class << self
        def base_url
          @base_url ||= "v1/#{division}/"
        end

        def client
          @client ||= Client.new
        end

        def division
          @division ||= client.division
        end
      end

      def initialize(raw)
        @raw = raw
      end
    end
  end
end

require 'exact_online/resources/collection'
require 'exact_online/resources/customer'
require 'exact_online/resources/document_attachment'
require 'exact_online/resources/document'
require 'exact_online/resources/mailbox'
require 'exact_online/resources/purchase_invoice_lines'
require 'exact_online/resources/purchase_invoice'
