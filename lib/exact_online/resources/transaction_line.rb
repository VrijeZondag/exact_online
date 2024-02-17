# frozen_string_literal: true

module ExactOnline
  module Resources
    class TransactionLine < Base
      attr_accessor :guid, :amount, :date, :description, :entryId, :financialPeriod,
                    :financialYear, :glAccountCode, :glAccountId, :glAccountDescription, :journal

      @service = Services::TransactionLinesApi

      def initialize(attributes = {})
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
