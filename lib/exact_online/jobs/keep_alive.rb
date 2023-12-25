# frozen_string_literal: true

module ExactOnline
  module Jobs
    class KeepAlive < ::ApplicationJob
      def perform
        ::ExactOnline.alive?
      end
    end
  end
end
