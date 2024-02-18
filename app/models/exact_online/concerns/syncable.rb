# frozen_string_literal: true

module ExactOnline
  module Concerns
    module Syncable
      extend ActiveSupport::Concern

      included do
        after_create :sync
      end

      def sync
        @remote_record = ::ExactOnline.find_transaction_line(guid)
        return unless @remote_record

        update(@remote_record.attributes)
      end
    end
  end
end
