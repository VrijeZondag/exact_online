# frozen_string_literal: true

## Api::ExactOnline::Resources::Mailbox.get

module ExactOnline
  module Resources
    class Mailbox < Base
      FULL_EXAMPLE_RESOURCE = "/api/v1/{division}/read/mailbox/DefaultMailbox?$filter=ID eq \
                              guid'00000000-0000-0000-0000-000000000000'&$select=Created"
      RESOURCE              = "mailbox/Mailboxes"
      SCANSERVICE_SELECTOR  = "?$filter=IsScanServiceMailbox eq true"
      SELECT_FIELDS         = "&$select=Description,Creator,Mailbox"

      class << self
        def get
          raw_response = client.token.get(resource_url).response.body
          new(Hash.from_xml(raw_response))
        end

        def get_with_url_string(url)
          raw_response = client.token.get(base_url + RESOURCE + url).response.body
          new(Hash.from_xml(raw_response))
        end

        def resource_url
          base_url + RESOURCE + SCANSERVICE_SELECTOR + SELECT_FIELDS
        end
      end

      def initialize(raw_result)
        @raw_result = raw_result
      end
    end
  end
end
