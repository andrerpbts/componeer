module Componeer
  module Helpers
    def self.define_component_helper(name)
      define_method(name) do |*args, **options, &block|
        render Componeer.registry.fetch(name).new(*args, **options), &block
      end
    end

    def componeer_stylesheets(**options)
      stylesheet_link_tag "componeer/tokens", "componeer/components", **options
    end
  end
end
