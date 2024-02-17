# frozen_string_literal: true

# ExactOnline::Services::TransactionLinesApi.find("f5b597d0-97c9-4f09-bf4b-d58aeed8c593")

module ExactOnline
  module Services
    class TransactionLinesApi < Base
      @resource_path = 'financialtransaction/TransactionLines'
      @bulk_resource_path = 'bulk/Financial/TransactionLines'
      @sync_resource_path = 'sync/Financial/TransactionLines'
      @attributes = %w[AccountCode AccountName AmountDC AmountFC Date]
    end
  end
end
