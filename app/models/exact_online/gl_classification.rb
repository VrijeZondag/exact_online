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

    has_many :accounts,
             through: :mappings,
             class_name: 'ExactOnline::GlAccount',
             foreign_key: :gl_account_guid,
             primary_key: :guid

    has_many :transaction_lines, through: :accounts

    class << self
      attr_reader :service, :resource
    end

    def parent_classification
      where(guid: parent).first
    end

    def classifications
      where(parent:)
    end

    def scheme
      schemes.first
    end
  end
end
