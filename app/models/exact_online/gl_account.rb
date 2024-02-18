# frozen_string_literal: true

module ExactOnline
  class GlAccount < ApplicationRecord
    extend Concerns::TableNameHelper
    include Concerns::Syncable

    @service = ExactOnline::Services::GlAccountsApi
    @resource = ExactOnline::Resources::GlAccount

    has_many :mappings,
             class_name: 'ExactOnline::GlAccountClassificationMapping',
             foreign_key: :gl_account_guid,
             primary_key: :guid

    has_many :classifications,
             through: :mappings,
             class_name: 'ExactOnline::GlClassification',
             foreign_key: :classification_guid,
             primary_key: :guid

    has_many :schemes,
             through: :mappings,
             class_name: 'ExactOnline::GlScheme',
             foreign_key: :gl_scheme_guid,
             primary_key: :guid

    has_many :transaction_lines, foreign_key: :glAccountCode, primary_key: :code

    class << self
      attr_reader :service, :resource
    end
  end
end
