# frozen_string_literal: true

module ExactOnline
  module Services
    class GlClassificationsApi < Base
      @resource_path = 'financial/GLClassifications'
      @bulk_resource_path = 'bulk/Financial/GLClassifications'
      @attributes = %w[ID Code Description Name Parent TaxonomyNamespace TaxonomyNamespaceDescription Type]
    end
  end
end
