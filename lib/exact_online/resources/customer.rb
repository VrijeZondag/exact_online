# frozen_string_literal: true

module ExactOnline
  module Resources
    class Customer < Base
      attr_accessor :id, :name, :email, :phone, :address, :city, :postcode, :country, :status,
                    :code, :is_sales, :is_supplier

      @service = Services::CustomersApi

      class << self
        def find_by_email(email)
          @service.where(Email: email).map { |customer| new(customer) }
        end
      end

      # def initialize(attributes = {})
      #   @attributes = if attributes.dig('content', 'properties').nil?
      #                   attributes
      #                 else
      #                   attributes.dig('content', 'properties')
      #                 end

      #   @id = @attributes['ID']
      #   @name = @attributes['Name']
      #   @email = @attributes['Email']
      #   @phone = @attributes['Phone']
      #   @address = @attributes['AddressLine1']
      #   @city = @attributes['City']
      #   @postcode = @attributes['Postcode']
      # end

      def initialize(attributes = {})
        @id = attributes['ID']
        @name = attributes['Name']
        @email = attributes['Email']
        @address = attributes['AddressLine1']
        @city = attributes['City']
        @postcode = attributes['Postcode']
        @phone = attributes['Phone']
        @status = attributes['Status']
        @code = attributes['Code']
        @is_sales = attributes['IsSales']
        @is_supplier = attributes['IsSupplier']
      end

      def save
        self.class.service.create(self)
      end
    end
  end
end
