# frozen_string_literal: true

## For testing purposes
## Api::ExactOnline::Resources::PurchaseInvoice.get("f0e209a3-e7de-4852-adaf-fde94d269a66")
## Api::ExactOnline::Resources::PurchaseInvoice.get("ad6dec35-28f1-44f6-a668-a152eeb15f27")
## Api::ExactOnline::Resources::PurchaseInvoice.get("9376c31e-23c9-41d1-85cf-888d46cb7a75")

module ExactOnline
  module Resources
    class PurchaseInvoice < Base
      RESOURCE = 'purchaseentry/PurchaseEntries'
      GLANS = %w[7000 7001 7002 7011 7012 7022].freeze
      attr_accessor :properties

      @service = Services::PurchaseInvoicesApi
      @properties = [
        id: "EntryID",
        invoice_amount: "AmountDC",
        vat: "VATAmountDC",
        supplier_name: "SupplierName",
        supplier_id: "Supplier",
        invoice_number: "InvoiceNumber",
        invoice_date: "EntryDate",
        document_id: "Document"
      ]

      class << self
        attr_reader :properties
      end

      attr_accessor :invoice_amount, :id, :vat, :amount_without_vat, :supplier_name,
                    :supplier_id, :invoice_number, :invoice_date, :document_id

      class << self
        alias_method :get, :find
      end

      def initialize(raw)
        properties = raw

        @id = properties['EntryID']
        @invoice_amount = properties['AmountDC'].to_d * -1
        @vat = properties['VATAmountDC'].to_d * -1
        @amount_without_vat = @invoice_amount - @vat
        @supplier_name = properties['SupplierName']
        @supplier_id = properties['Supplier']
        @invoice_number = properties['InvoiceNumber']
        @invoice_date = properties['EntryDate']
        @document_id = properties['Document']
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
    end
  end
end
