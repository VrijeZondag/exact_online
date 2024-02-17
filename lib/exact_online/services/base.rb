# frozen_string_literal: true

module ExactOnline
  module Services
    class Base
      attr_reader :client

      delegate :base_url, :division, to: :client

      class << self
        attr_reader :resource_path, :attributes

        delegate :find, :where, to: :new

        ## To Implement
        def create; end

        def all; end

        def update; end
      end

      def initialize(client = Client.new)
        @client = client
      end

      def find(id)
        url = "#{base_url}#{resource_path}(guid'#{id}')"
        response = client.get(url).response.body
        parse_singleton_response(response)
      end

      def where(**attributes)
        url = "#{base_url}#{resource_path}?#{filter(attributes)}#{collect_selected_attributes}"
        response = client.get(url).response.body
        parse_response(response)
      end

      def resource_path
        self.class.resource_path
      end

      private

      def filter(attributes)
        return nil if attributes.blank?

        filter_attributes = attributes.map do |key, value|
          "#{key} eq #{strip_extra_apostrophe_for_guid(value)}"
        end.join(' and ')
        "$filter=#{filter_attributes}"
      end

      def strip_extra_apostrophe_for_guid(value)
        return value if value.include? 'guid'

        "'#{value}'"
      end

      def collect_selected_attributes
        return nil if self.class.attributes.blank?

        attributes_csv = self.class.attributes.join(',') if self.class.attributes.present?
        "&$select=#{attributes_csv}"
      end

      def parse_response(response)
        result = Hash.from_xml(response).dig('feed', 'entry')
        if result.is_a?(Hash)
          [result]
        else
          result
        end
      end

      def parse_singleton_response(result)
        Hash.from_xml(result).dig('entry', 'content', 'properties')
      end
    end
  end
end
