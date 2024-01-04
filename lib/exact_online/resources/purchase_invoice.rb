# frozen_string_literal: true

## For testing purposes
## Api::ExactOnline::Resources::PurchaseInvoice.get("f0e209a3-e7de-4852-adaf-fde94d269a66")
## Api::ExactOnline::Resources::PurchaseInvoice.get("ad6dec35-28f1-44f6-a668-a152eeb15f27")
## Api::ExactOnline::Resources::PurchaseInvoice.get("9376c31e-23c9-41d1-85cf-888d46cb7a75")

module ExactOnline
  module Resources
    class PurchaseInvoice < Base
      GLANS = %w[7000 7001 7002 7011 7012 7022].freeze

      class << self
        attr_reader :properties

        alias get find
      end

      attr_accessor :id, :supplier_name,
                    :supplier_id, :invoice_number, :invoice_date, :document_id
      attr_reader :invoice_amount, :vat

      @service = Services::PurchaseInvoicesApi
      @properties = {
        id: "EntryID",
        invoice_amount: "AmountDC",
        vat: "VATAmountDC",
        supplier_name: "SupplierName",
        supplier_id: "Supplier",
        invoice_number: "InvoiceNumber",
        invoice_date: "EntryDate",
        document_id: "Document"
      }

      def initialize(raw)
        super(raw)

        self.class.properties.each do |key, value|
          self.method("#{key}=").(@properties[value])
        end
      end

      def purchase_lines?
        order_lines.collection.any? { |line| GLANS.include?(line.gl_account_code) }
      end

      def order_lines
        @order_lines ||= PurchaseInvoiceLines.get_from_invoice(@id)
      end

      def document
        @document ||= DocumentAttachment.get(@document_id)
      end

      def invoice_amount=(amount)
        @invoice_amount = amount.to_d * -1
      end

      def vat=(amount)
        @vat = amount.to_d * -1
      end

      def amount_without_vat
        @invoice_amount - @vat
      end
    end
  end
end
