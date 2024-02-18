# frozen_string_literal: true

module ExactOnline
  class ImportAllJob < ApplicationJob
    queue_as :default

    def perform
      import(GlAccount)
      import(GlClassification)
      import(GlAccountClassificationMapping)
      import(TransactionLine)
      GlScheme.setup
    end

    def import(model)
      ImportJob.new(model).perform_now
    end
  end
end
