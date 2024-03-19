# frozen_string_literal: true

module ExactOnline
  class Account < ApplicationRecord
    extend Concerns::TableNameHelper
    include Concerns::Syncable

    @service = ExactOnline::Services::CustomersApi
    @resource = ExactOnline::Resources::Customer

    has_many :transactions,
      class_name: 'ExactOnline::TransactionLine',
      foreign_key: :account_code,
      primary_key: :code

    class << self
      attr_reader :service, :resource
    end

    def balance
      transactions.map(&:amount).sum
    end
  end
end
