module Componeer
  class Engine < ::Rails::Engine
    isolate_namespace Componeer

    initializer "componeer.helpers" do
      ActiveSupport.on_load(:action_view) { include Componeer::Helpers }
    end

    initializer "componeer.assets" do |app|
      if app.config.respond_to?(:assets)
        app.config.assets.paths << root.join("app/javascript")
      end
    end

    initializer "componeer.importmap", before: "importmap" do |app|
      if app.config.respond_to?(:importmap)
        app.config.importmap.paths << root.join("config/importmap.rb")
        app.config.importmap.cache_sweepers << root.join("app/javascript")
      end
    end

    config.to_prepare do
      Componeer::Icons.reset! if Rails.env.local?
    end
  end
end
