# frozen_string_literal: true

module ExactOnline
  module Resources
    class Base
      class << self
        def base_url
          @base_url ||= "v1/#{division}/"
        end

        def client
          @client ||= Client.new
        end

        def division
          @division ||= client.division
        end

        def find(id)
          new(@service.find(id))
        end

        def where(**attributes)
          Collection.new(@service.where(**attributes).map { |raw| new(raw) })
        end

        attr_reader :service
      end

      def initialize(raw)
        @properties = raw
      end
    end
  end
end
