# frozen_string_literal: true

module ExactOnline
  class GlAccount < ApplicationRecord
    extend Concerns::TableNameHelper
    include Concerns::Syncable

    @service = ExactOnline::Services::GlAccountsApi
    @resource = ExactOnline::Resources::GlAccount

    class << self
      attr_reader :service, :resource
    end
  end
end
