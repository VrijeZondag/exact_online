# frozen_string_literal: true

module ExactOnline
  module Resources
    class Document < Base
      ID_KEY = %w[entry content properties ID].freeze
      URL_KEY = %w[entry content properties DocumentViewUrl].freeze
      DOCUMENT_PATH = 'documents/Documents'
      FILTER_PARAM = "(guid'%s')"

      attr_reader :id, :url

      class << self
        def get(id)
          response = client.token.get(document_url(id)).response
          return nil unless response.success?

          new(Hash.from_xml(response.body))
        end

        def document_url(id)
          [base_url, DOCUMENT_PATH, FILTER_PARAM % id].join
        end
      end

      def initialize(raw)
        @raw = raw
        @id = raw.dig(*ID_KEY)
        @url = raw.dig(*URL_KEY)
      end

      def download(client = default_client)
        response = client.token.get(strip_base_url)

        if response.success?
          response.body
        else
          handle_error(response)
        end
      end

      private

      def default_client
        Client.new(site_blank: true)
      end

      def remove_site_prefix
        url.gsub(site_prefix, '')
      end

      def site_prefix
        Client::SITE
      end

      def handle_error(response)
        case response.status
        when 404
          raise 'Document not found'
        when 401
          raise 'Unauthorized access'
        when 500
          raise 'Internal server error'
        else
          raise "Error occurred while downloading the document: #{response.status} #{response.reason_phrase}"
        end
      end
    end
  end
end
