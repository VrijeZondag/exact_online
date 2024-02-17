# frozen_string_literal: true

module ExactOnline
  class Engine < ::Rails::Engine
    # isolate_namespace ExactOnline

    # initializer 'ExactOnline.add_routes', after: :add_routing_paths do |app|
    #   app.routes.prepend do
    #     mount ExactOnline::Engine, at: '/'
    #   end
    # end
  end
end
