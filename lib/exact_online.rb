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
  end

  def find_customers_by_email(email)
    Resources::Customer.find_by(email:)
  end
end

require 'exact_online/configuration'
require 'exact_online/client'

require 'exact_online/jobs/create_purchase_invoice'
require 'exact_online/jobs/keep_alive'

require 'exact_online/resources/base'
require 'exact_online/services/base'
require 'exact_online/token/manager'
require 'exact_online/token/refresher'

require 'exact_online/o_auth_handler'
require 'exact_online/webhook'
