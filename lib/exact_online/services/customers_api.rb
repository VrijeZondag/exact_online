# frozen_string_literal: true

module ExactOnline
  module Services
    class CustomersApi < Base
      @resource = 'crm/Accounts'

      class << self
        delegate :find_by_email, to: :new

        def find_by(attributes = {})
          raise 'Not implemented' if attributes[:email].blank?

          find_by_email(attributes[:email])
        end
      end

      def find_by_email(email)
        url = "#{base_url}#{@resource}?$filter=Email eq '#{email}'"
        response = client.get(url).response.body
        parse_response(response)
      end
    end
  end
end
