# frozen_string_literal: true

module ExactOnline
  class ImportJob < ApplicationJob
    queue_as :default
    attr_reader :model, :service, :resource

    def perform(model)
      @model = model
      @service = model.service
      @resource = model.resource

      Rails.logger.info "Service: #{service.bulk_resource_path}"
      import_batch
      Rails.logger.info("Imported #{model.all.count} records")
    end

    def import_batch
      @result = Hash.from_xml(service.new.client.get(next_link).response.body)

      create_records

      import_batch if extract_next_url_from_result
    end

    def create_records
      model.insert_all(entries)
      Rails.logger.info("Creating #{entries.count} records")
      Rails.logger.info("nu #{model.all.count} records")
      @entries = nil
    end

    def next_link
      if @result
        extract_next_url_from_result
      else
        service.bulk_import_url
      end
    end

    def extract_next_url_from_result
      @result&.dig('feed', 'link')
             &.find { |link| link['rel'] == 'next' }
             &.fetch('href', nil)
             &.remove('https://start.exactonline.nl/api/')
    rescue StandardError
      nil
    end

    def entries
      @entries ||= @result.dig('feed', 'entry').map do |entry|
        resource.new(entry.dig('content', 'properties')).attributes
      end
    end
  end
end
