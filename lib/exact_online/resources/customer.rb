# frozen_string_literal: true

module ExactOnline
  module Resources
    class Customer < Base
      attr_accessor :exact_id, :name, :email, :phone, :address, :city, :postcode, :country, :status,
                    :code, :is_sales, :is_supplier

      @service = Services::CustomersApi

      class << self
        def find_by_email(email)
          @service.find_by_email(email).map { |customer| new(customer.dig('content', 'properties')) }
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
        @exact_id = attributes['ID']
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

      def attributes
        hash = {}
        instance_variables.each do |v|
          attribute = v.to_s.delete('@')
          hash[attribute] = instance_variable_get(v)
        end
        hash
      end
    end
  end
end
