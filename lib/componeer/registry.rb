module Componeer
  class Registry
    class NameTaken < ArgumentError; end

    def initialize
      @components = {}
    end

    def register(name, component)
      name = name.to_sym
      raise NameTaken, "#{name} would override an Action View helper" if reserved?(name)

      @components[name] = component.to_s
      Helpers.define_component_helper(name)
    end

    def fetch(name)
      @components.fetch(name.to_sym).constantize
    end

    def names
      @components.keys
    end

    def include?(name)
      @components.key?(name.to_sym)
    end

    private
    def reserved?(name)
      !include?(name) && ActionView::Base.method_defined?(name) &&
        ActionView::Base.instance_method(name).owner != Helpers
    end
  end
end
