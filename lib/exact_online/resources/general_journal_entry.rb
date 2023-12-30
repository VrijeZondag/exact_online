# frozen_string_literal: true

module ExactOnline
  module Resources
    class GeneralJournalEntry < Base
      class << self
        def find_by_entry_nr(entry_number)
          Services::GeneralJournalEntriesApi.find_by_entry_nr(entry_number).map do |entry|
            new(entry)
          end
        end
      end

      def initialize(attributes = {})
        @attributes = attributes.dig('content', 'properties')
      end
    end
  end
end
