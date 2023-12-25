# frozen_string_literal: true

module Public
  module ExactOnline
    class AuthenticationsController < Base
      def new
        redirect_to ::ExactOnline::Client.new.authorize_url, allow_other_host: true
      end

      def webhook
        ::ExactOnline::Client.new.receive_code(params["code"])

        redirect_to root_path, notice: "Exact Online is geautoriseerd"
      end
    end
  end
end
