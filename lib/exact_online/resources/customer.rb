# frozen_string_literal: true

module ExactOnline
  module Resources
    class Customer < Base
      attr_accessor :id, :name, :email, :phone, :address, :city, :postcode, :country, :status

      class << self
        def find_by_email(email)
          Services::CustomersApi.find_by(email:).map do |customer|
            new(customer)
          end
        end
      end

      def initialize(attributes = {})
        @attributes = attributes.dig("content", "properties")
        @id = @attributes["ID"]
        @name = @attributes["Name"]
        @email = @attributes["Email"]
        @phone = @attributes["Phone"]
        @address = @attributes["AddressLine1"]
        @city = @attributes["City"]
        @postcode = @attributes["Postcode"]
      end
    end
  end
end
