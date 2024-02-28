class ExactOnline::Account < ApplicationRecord
  extend Concerns::TableNameHelper
  include Concerns::Syncable

  @service = ExactOnline::Services::CustomersApi
  @resource = ExactOnline::Resources::Customer
end
