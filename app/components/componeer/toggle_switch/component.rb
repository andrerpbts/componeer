module Componeer
  module ToggleSwitch
    # A real checkbox (it submits with forms) drawn as a switch.
    class Component < BaseComponent
      def initialize(name, label:, checked: false, value: "1", **html)
        @name = name
        @label = label
        @checked = checked
        @value = value
        @html = html
      end

      private

      def input_attributes
        html_attributes "tr-sr-only", @html,
          type: "checkbox", role: "switch", name: @name, value: @value, checked: @checked
      end
    end
  end
end
