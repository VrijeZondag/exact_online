# frozen_string_literal: true

module ExactOnline
  class Account < ApplicationRecord
    extend Concerns::TableNameHelper
    include Concerns::Syncable

    @service = ExactOnline::Services::CustomersApi
    @resource = ExactOnline::Resources::Customer
  end
end
