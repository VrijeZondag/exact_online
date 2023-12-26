# frozen_string_literal: true

## ExactOnline::Jobs::CreatePurchaseInvoice.perform_now("f0e209a3-e7de-4852-adaf-fde94d269a66")

module ExactOnline
  module Jobs
    class CreatePurchaseInvoice < ActiveJob::Base
      def perform(id)
        invoice = get_invoice_from_exact_online(id)

        if invoice.purchase_lines?
          create_or_update_invoice(invoice)
          log_info "Purchase invoice #{invoice.invoice_number} created"
        else
          log_info "No purchase lines found for invoice #{invoice.invoice_number}"
        end
        true
      rescue StandardError => e
        log_error "Error during CreatePurchaseInvoiceJob: #{e.message}"
      end

      def create_or_update_invoice(invoice)
        i = purchase_invoice(invoice.id)
        i.assign_attributes(updated_invoice_attributes(invoice))

        attach_document_to_invoice(i, invoice.document)
        ActiveRecord::Base.transaction { i.save! }
      end

      def updated_invoice_attributes(invoice_data)
        {
          invoice_nr: invoice_data.invoice_number,
          amount_without_vat: invoice_data.amount_without_vat,
          vat_amount: invoice_data.vat,
          amount_with_vat: invoice_data.invoice_amount,
          invoice_date: invoice_data.invoice_date
        }
      end

      def purchase_invoice(id)
        Finance::PurchaseInvoice.find_or_create_by(exact_id: id)
      end

      def attach_document_to_invoice(invoice, document)
        file_content = document.download
        return unless file_content

        io = StringIO.new(file_content)
        invoice.document.attach(io:, filename: document.filename, content_type: 'application/pdf')
      end

      def get_invoice_from_exact_online(id)
        Resources::PurchaseInvoice.get(id)
      end

      def log_info(message)
        Rails.logger.info(message)
      end

      def log_error(message)
        Rails.logger.error(message)
      end
    end
  end
end
