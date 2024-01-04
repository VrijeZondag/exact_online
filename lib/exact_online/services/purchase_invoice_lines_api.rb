# frozen_string_literal: true

module ExactOnline
  module Services
    class PurchaseInvoiceLinesApi < Base
      @resource_path = 'purchaseentry/PurchaseEntryLines'
      @attributes = %w[AmountDC AmountFC CostCenter CostUnit Description Division VATBaseAmountDC GLAccountCode]
    end
  end
end
