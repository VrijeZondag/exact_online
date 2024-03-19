module ExactOnline
  class ClearAndImportAllJob < ApplicationJob
    queue_as :default

    def perform
      delete_all
      ImportAllJob.new.perform_now
    end

    def delete_all
      models.each(&:delete_all)
    end

    def models
      [
        ExactOnline::GlAccount,
        ExactOnline::GlClassification,
        ExactOnline::GlAccountClassificationMapping,
        ExactOnline::TransactionLine,
        ExactOnline::Account,
        ExactOnline::GlScheme
      ].reverse
    end
  end
end