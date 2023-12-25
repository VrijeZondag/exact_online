# frozen_string_literal: true

module ExactOnline
  module Jobs
    class KeepAlive < ActiveJob::Base
      def perform
        ::ExactOnline.alive?
      end
    end
  end
end
