# frozen_string_literal: true

# ExactOnline::Services::TransactionLinesApi.find("f5b597d0-97c9-4f09-bf4b-d58aeed8c593")

module ExactOnline
  module Services
    class GlAccountsApi < Base
      @resource_path = 'financial/GLAccounts'
      @bulk_resource_path = 'bulk/Financial/GLAccounts'
      # @sync_resource_path = 'sync/Financial/TransactionLines'
      @attributes = %w[ID Code Description Type]
    end
  end
end
