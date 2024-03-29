# frozen_string_literal: true

module ExactOnline
  module Resources
    class GlClassification < Base
      attr_accessor :guid, :code, :description, :name, :parent, :namespace, :classification_type, :namespace_description

      @service = Services::GlClassificationsApi

      def initialize(attributes = {})
        @guid = attributes['ID']
        @code = attributes['Code']
        @description = attributes['Description']
        @name = attributes['Name']
        @parent = attributes['Parent']
        @namespace = attributes['TaxonomyNamespace']
        @namespace_description = attributes['TaxonomyNamespaceDescription']
        @classification_type = attributes['Type']
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
