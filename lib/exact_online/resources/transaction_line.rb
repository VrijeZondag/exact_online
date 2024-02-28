# frozen_string_literal: true

module ExactOnline
  module Resources
    class TransactionLine < Base
      attr_accessor :guid, :amount, :date, :description, :entryId, :financialPeriod,
                    :financialYear, :glAccountCode, :glAccountId, :glAccountDescription, :journal,
                    :status, :transaction_line_type, :account_code, :account_name, :document_number,
                    :invoice_number, :item, :tracking_number

      @service = Services::TransactionLinesApi

      def initialize(attributes = {})
        @guid = attributes['ID']
        @amount = attributes['AmountDC']
        @date = attributes['Date']
        @description = attributes['Description']
        @entryId = attributes['EntryID']
        @financialPeriod = attributes['FinancialPeriod']
        @financialYear = attributes['FinancialYear']
        @glAccountCode = attributes['GLAccountCode']
        @glAccountId = attributes['GLAccount']
        @glAccountDescription = attributes['GLAccountDescription']
        @journal = attributes['JournalCode']
        @status = attributes['Status']
        @transaction_line_type = attributes['Type']
        @account_code = attributes['AccountCode']
        @account_name = attributes['AccountName']
        @document_number = attributes['DocumentNumber']
        @invoice_number = attributes['InvoiceNumber']
        @item = attributes['Item']
        @tracking_number = attributes['TrackingNumber']
      end

      def attributes
        hash = {}
        instance_variables.each do |v|
          attribute = v.to_s.delete('@')
          hash[attribute] = instance_variable_get(v)
        end
        hash
      end
    end
  end
end
