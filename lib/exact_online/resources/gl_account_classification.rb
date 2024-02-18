# frozen_string_literal: true

module ExactOnline
  module Resources
    class GlAccountClassification < Base
      attr_accessor :guid,
                    :classification_guid, :classification_code, :classification_description,
                    :gl_account_guid, :gl_account_code, :gl_account_description,
                    :gl_scheme_guid, :gl_scheme_code, :gl_scheme_description

      @service = Services::GlAccountsClassificationsApi

      def initialize(attributes = {})
        @guid = attributes['ID']
        @classification_guid = attributes['Classification']
        @classification_code = attributes['ClassificationCode']
        @classification_description = attributes['ClassificationDescription']

        @gl_account_guid = attributes['GLAccount']
        @gl_account_code = attributes['GLAccountCode']
        @gl_account_description = attributes['GLAccountDescription']

        @gl_scheme_guid = attributes['GLSchemeID']
        @gl_scheme_code = attributes['GLSchemeCode']
        @gl_scheme_description = attributes['GLSchemeDescription']
      end

      def attributes
        hash = {}
        instance_variables.each do |v|
          attribute = v.to_s.delete('@')
          hash[attribute] = instance_variable_get(v)
        end
        hash
      end
    end
  end
end
