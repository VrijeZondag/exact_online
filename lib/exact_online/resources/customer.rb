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

        def find(id)
          # Rails.logger.info Services::CustomersApi.find(id)
          new(Services::CustomersApi.find(id))
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
    end
  end
end
