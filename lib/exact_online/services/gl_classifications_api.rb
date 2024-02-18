# frozen_string_literal: true

module ExactOnline
  module Services
    class GlClassificationsApi < Base
      @resource_path = 'financial/GLClassifications'
      @bulk_resource_path = 'bulk/Financial/GLClassifications'
      @attributes = %w[ID Code Description Name Parent Namespace Type]
    end
  end
end
