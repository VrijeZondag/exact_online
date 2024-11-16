# frozen_string_literal: true

require 'exact_online/version'
require 'exact_online/engine'
module ExactOnline
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def alive?
      Client.new.alive?
    end

    def find_customers_by_email(email)
      Resources::Customer.where("Email": email)
    end

    def find_transaction_line(guid)
      Resources::TransactionLine.find(guid)
    end

    def create_test_sales_invoice
      ExactOnline::Services::SalesInvoicesApi.new.create(ordered_by: "a6c512e8-d08b-4817-9dc7-21cc3771cad5", invoice_lines: [{item: "229614d9-07b8-4233-a87f-7abef2c79eef", quantity: 1}, {item: "229614d9-07b8-4233-a87f-7abef2c79eef", quantity: 2}])
    end

    def create_sales_invoice(customer_id, invoice_lines)
      ExactOnline::Services::SalesInvoicesApi.new.create(ordered_by: customer_id, invoice_lines: invoice_lines)
    end
  end
end

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")

loader.setup
