# frozen_string_literal: true

module ExactOnline
  module Services
    class SalesInvoicesApi < Base
      @resource_path = 'salesinvoice/SalesInvoices'
      @attributes = %w[AmountDC Description OrderedBy Journal SalesInvoiceLines]

      def create(ordered_by:, invoice_lines:, journal: 70)
        url = "#{base_url}#{resource_path}"
        body = {
          "OrderedBy": ordered_by,
          "Journal": journal,
          "SalesInvoiceLines": format_invoice_lines(invoice_lines)
        }

        puts body

        response = client.post(url) do |req|
          req.body = body.to_json
          req.headers['Content-Type'] = 'application/json'
        end

        Hash.from_xml(response.response.body).dig('entry', 'content', 'properties', 'InvoiceID')
      end

      def format_invoice_lines(invoice_lines)
        invoice_lines.map do |invoice_line|
          {
            "Item" => invoice_line[:item],
            "Quantity" => invoice_line[:quantity],
            "GLAccount" => "376cb84e-eafa-4bcd-8715-3c8b321bd2bf",
            "AmountFC" => invoice_line[:price],
            "Description" => invoice_line[:description],
            "UnitPrice" => invoice_line[:price],
            "AmountDC" => invoice_line[:price]
          }.compact
        end
      end
    end
  end
end

## Takes:

# ExactOnline::Services::SalesInvoicesApi.create(ordered_by: "a6c512e8-d08b-4817-9dc7-21cc3771cad5", invoice_lines: [{item: "229614d9-07b8-4233-a87f-7abef2c79eef", quantity: 1}, {item: "229614d9-07b8-4233-a87f-7abef2c79eef", quantity: 2}])