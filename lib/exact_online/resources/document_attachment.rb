# frozen_string_literal: true

module ExactOnline
  module Resources
    class DocumentAttachment < Base
      PDF_EXTENSION     = ".pdf"
      EXACT_ONLINE_BASE = "https://start.exactonline.nl"
      FILTER_PARAM      = "?$filter=Document eq guid'%s'&"
      SELECT_PARAMS     = "$select=FileName,FileSize,Url,Attachment"
      DOWNLOAD_PARAM    = "&Download=1"

      DOCUMENT_PATH = "bulk/Documents/DocumentAttachments"

      URL_KEY           = %w[content properties Url].freeze
      FILENAME_KEY      = %w[content properties FileName].freeze

      attr_accessor :url, :filename
      attr_reader :raw

      class << self
        def get(id)
          response = client.token.get(document_url(id)).response
          return nil unless response.success?

          new(Hash.from_xml(response.body))
        end

        def document_url(id)
          [base_url, DOCUMENT_PATH, FILTER_PARAM % id, SELECT_PARAMS].join
        end
      end

      def initialize(raw_data)
        @raw = raw_data
        extract_file_data!
      end

      def download(client = default_client)
        response = client.token.get(download_url).response

        response.body
      end

      def pdf_file
        @pdf_file ||= files.find do |file|
          filename = file.dig(*FILENAME_KEY)
          File.extname(filename.to_s).downcase == PDF_EXTENSION
        end
      end

      def files
        @files ||= Array(raw.dig("feed", "entry"))
      end

      private

      def extract_file_data!
        self.url = pdf_file&.dig(*URL_KEY)
        self.filename = files.dig(1, *FILENAME_KEY)
      end

      def default_client
        Client.new(omit_api_suffix: true)
      end

      def remove_base_from_url
        url.gsub(EXACT_ONLINE_BASE, "")
      end

      def download_url
        "#{remove_base_from_url}#{DOWNLOAD_PARAM}"
      end
    end
  end
end
