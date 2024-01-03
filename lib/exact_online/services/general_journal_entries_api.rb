# frozen_string_literal: true

module ExactOnline
  module Services
    class GeneralJournalEntriesApi < Base
      @resource_path = 'generaljournalentry/GeneralJournalEntries'

      class << self
        delegate :find_by_entry_nr, to: :new
      end

      def find_by_entry_nr(entry_number)
        url = "#{base_url}#{@resource}?$filter=EntryNumber eq '#{entry_number}'"
        response = client.get(url).response.body
        parse_response(response)
      end
    end
  end
end
