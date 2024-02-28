# frozen_string_literal: true

# ExactOnline::ImportJob.perform_now(ExactOnline::GlClassification)

module ExactOnline
  class ImportAllJob < ApplicationJob
    queue_as :default

    def perform
      import(ExactOnline::GlAccount)
      import(ExactOnline::GlClassification)
      import(ExactOnline::GlAccountClassificationMapping)
      import(ExactOnline::TransactionLine)
      import(ExactOnline::Account)
      GlScheme.setup
    end

    def import(model)
      ImportJob.new(model).perform_now
    end
  end
end
