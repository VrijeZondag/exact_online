# frozen_string_literal: true

module ExactOnline
  module Services
    class CustomersApi < Base
      @resource_path = 'crm/Accounts'

      class << self
        delegate :find_by_email, :save, to: :new

        def find_by(attributes = {})
          raise 'Not implemented' if attributes[:email].blank?

          find_by_email(attributes[:email])
        end

        def create(attributes = {})
          save(attributes)
        end
      end

      def find_by_email(email)
        url = "#{base_url}#{resource_path}?$filter=Email eq '#{email}'"
        response = client.get(url).response.body
        parse_response(response)
      end

      def save(attributes = {})
        url =  "#{base_url}#{resource_path}"
        body = {
          "Name": attributes.name,
          "Email": attributes.email,
          "AddressLine1": attributes.address,
          "City": attributes.city,
          "Postcode": attributes.postcode,
          "Phone": attributes.phone
        }
        options = {"Content-Type" => "application/json"}

        puts client
        response = client.post(url) do |req|
          req.body = body.to_json
          req.headers = options
        end
          
        puts response
      end
    end
  end
end
