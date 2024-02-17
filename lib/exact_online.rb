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
  end
end

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")

loader.setup
