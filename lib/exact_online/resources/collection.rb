# frozen_string_literal: true

module ExactOnline
  module Resources
    class Collection
      include Enumerable
      attr_accessor :collection

      def initialize(collection)
        @collection = collection
      end

      def each(&)
        @collection.each(&)
      end
    end
  end
end
