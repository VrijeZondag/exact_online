# frozen_string_literal: true

module ExactOnline
  class GlAccountClassificationMapping < ApplicationRecord
    extend Concerns::TableNameHelper
    include Concerns::Syncable

    belongs_to :scheme, class_name: 'ExactOnline::GlScheme', foreign_key: :gl_scheme_guid, primary_key: :guid
    belongs_to :account, class_name: 'ExactOnline::GlAccount', foreign_key: :gl_account_guid, primary_key: :guid
    belongs_to :classification, class_name: 'ExactOnline::GlClassification', foreign_key: :classification_guid,
                                primary_key: :guid

    @service = ExactOnline::Services::GlAccountsClassificationsApi
    @resource = ExactOnline::Resources::GlAccountClassification

    class << self
      attr_reader :service, :resource
    end
  end
end
