# frozen_string_literal: true

require 'forwardable'

module ExactOnline
  module Services
    class Base
      attr_reader :client

      delegate :base_url, :division, to: :client

      class << self
        attr_reader :resource_path

        delegate :find, to: :new

        ## To Implement
        def create; end

        def all; end

        def update; end

        def where; end
      end

      def initialize(client = Client.new)
        @client = client
      end

      def find(id)
        url = "#{base_url}#{resource_path}(guid'#{id}')"
        response = client.get(url).response.body
        parse_singleton_response(response)
      end

      def resource_path
        self.class.resource_path
      end

      private

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
