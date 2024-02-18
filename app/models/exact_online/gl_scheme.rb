# frozen_string_literal: true

module ExactOnline
  class GlScheme < ApplicationRecord
    extend Concerns::TableNameHelper

    has_many :mappings,
             class_name: 'ExactOnline::GlAccountClassificationMapping',
             foreign_key: :gl_scheme_guid,
             primary_key: :guid

    has_many :classifications,
             through: :mappings,
             class_name: 'ExactOnline::GlClassification',
             foreign_key: :classification_guid,
             primary_key: :guid

    has_many :accounts,
             through: :mappings,
             class_name: 'ExactOnline::GlAccount',
             foreign_key: :gl_account_guid,
             primary_key: :guid

    def self.setup
      GlAccountClassificationMapping.distinct.pluck(:gl_scheme_guid, :gl_scheme_code,
                                                    :gl_scheme_description).each do |scheme|
        find_or_create_by(guid: scheme[0]) do |gl_scheme|
          gl_scheme.code = scheme[1]
          gl_scheme.description = scheme[2]
        end
      end
      GlClassification.where(parent: "---\nm:type: Edm.Guid\nm:null: 'true'\n").update_all(parent: nil)
    end

    def top_level_classifications
      classifications.where(parent: nil)
    end
  end
end
