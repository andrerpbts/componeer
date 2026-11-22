require "view_component"
require "componeer/version"
require "componeer/configuration"
require "componeer/registry"
require "componeer/helpers"
require "componeer/icons"
require "componeer/engine"

module Componeer
  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end

    def registry
      @registry ||= Registry.new
    end

    # Turns a component class into a view helper: register(:quest_card, "QuestCardComponent")
    # makes <%= quest_card(title: "…") do %>…<% end %> available in every view.
    def register(name, component)
      registry.register(name, component)
    end
  end
end

require "componeer/builtins"
