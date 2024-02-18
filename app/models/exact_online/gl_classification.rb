# frozen_string_literal: true

module ExactOnline
  class GlClassification < ApplicationRecord
    extend Concerns::TableNameHelper
    include Concerns::Syncable

    @service = ExactOnline::Services::GlClassificationsApi
    @resource = ExactOnline::Resources::GlClassification

    class << self
      attr_reader :service, :resource
    end
  end
end
