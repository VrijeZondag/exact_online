# frozen_string_literal: true

module ExactOnline
  module Resources
    class Customer < Base
      attr_accessor :id, :name, :email, :phone, :address, :city, :postcode, :country, :status

      @service = Services::CustomersApi

      class << self
        def find_by_email(email)
          @service.where(Email: email).map { |customer| new(customer) }
        end
      end

      def initialize(attributes = {})
        @attributes = if attributes.dig('content', 'properties').nil?
                        attributes
                      else
                        attributes.dig('content', 'properties')
                      end

        @id = @attributes['ID']
        @name = @attributes['Name']
        @email = @attributes['Email']
        @phone = @attributes['Phone']
        @address = @attributes['AddressLine1']
        @city = @attributes['City']
        @postcode = @attributes['Postcode']
      end

      def save
        self.class.service.create(self)
      end
    end
  end
end
