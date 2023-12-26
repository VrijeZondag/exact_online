# frozen_string_literal: true

module ExactOnline
  class Webhook
    attr_reader :guid, :topic, :url

    WEBHOOK_URL = "webhooks/WebhookSubscriptions".freeze

    def self.all
      client = ExactOnline::Client.new

      response = client.token.get((base_url + WEBHOOK_URL))
      collection = response_to_collection(response)

      Resources::Collection.new(collection)
    end

    def self.response_to_collection(response)
      raw_collection = Hash.from_xml(response.body)['feed']['entry']
      collection = raw_collection.is_a?(Hash) ? [raw_collection] : raw_collection
      if collection.nil?
        []
      else
        collection.map do |webhook|
          new(
            webhook.dig('content', 'properties', 'Topic'),
            webhook['content']['properties']['CallbackURL'],
            webhook['id']
          )
        end
      end
    end

    def self.base_url
      @base_url ||= "v1/#{ExactOnline::Client.division}/"
    end

    def initialize(topic, url, eo_url = nil)
      @topic = topic
      @url = url
      @eo_url = eo_url
    end

    def client
      ExactOnline::Client.new
    end

    def subscribe
      client.token.post((base_url + WEBHOOK_URL)) do |c|
        c.headers[:content_type] = 'application/json'
        c.body = { CallbackURL: @url, Topic: @topic }.to_json
      end
    end

    def base_url 
      @base_url ||= "v1/#{ExactOnline::Client.division}/"
    end

    def unsubscribe
      client.token.delete(@eo_url)
    end
  end
end
