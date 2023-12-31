# frozen_string_literal: true

module ExactOnline
  module Services
    class Base
      class << self
        def find(id)
          url = "#{base_url}#{@resource}(guid'#{id}')"
          response = client.get(url).response.body
          parse_response(response)
        end

        def create; end

        def all; end

        def update; end

        def where; end
      end

      def initialize(client = Client.new)
        @client = client
      end

      def base_url
        @base_url ||= "v1/#{division}/"
      end

      def client
        @client ||= Client.new
      end

      def division
        @division ||= client.division
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
    end
  end
end
