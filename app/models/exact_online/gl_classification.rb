# frozen_string_literal: true

module ExactOnline
  class GlClassification < ApplicationRecord
    extend Concerns::TableNameHelper
    include Concerns::Syncable

    @service = ExactOnline::Services::GlClassificationsApi
    @resource = ExactOnline::Resources::GlClassification

    has_many :mappings,
             class_name: 'ExactOnline::GlAccountClassificationMapping',
             foreign_key: :classification_guid,
             primary_key: :guid

    has_many :schemes, -> { distinct },
             through: :mappings,
             class_name: 'ExactOnline::GlScheme',
             foreign_key: :gl_scheme_guid,
             primary_key: :guid

    has_many :accounts, -> { distinct },
             through: :mappings,
             class_name: 'ExactOnline::GlAccount',
             foreign_key: :gl_account_guid,
             primary_key: :guid

    has_one :parent, class_name: 'ExactOnline::GlClassification', primary_key: :parent, foreign_key: :guid
    has_many :children, class_name: 'ExactOnline::GlClassification', primary_key: :guid, foreign_key: :parent

    has_many :transaction_lines, through: :accounts

    class << self
      attr_reader :service, :resource
    end

    def scheme
      schemes.first
    end
  end
end
