module Componeer
  module Tabs
    # One tab: a link when it has href:, otherwise a button that switches on the page.
    class Tab < BaseComponent
      SWITCH_ACTIONS = "componeer--tabs#select keydown->componeer--tabs#navigate".freeze

      def initialize(label, href: nil, count: nil, selected: false, panel: nil, **html)
        @label = label
        @href = href
        @count = count
        @selected = selected
        @panel = panel
        @html = html
      end

      private

      def attributes
        html_attributes("tr-tab", @html, role: "tab", aria: { selected: @selected.to_s })
      end

      def button_attributes
        attributes.deep_merge(
          type: "button", tabindex: @selected ? 0 : -1, id: ("#{@panel}-tab" if @panel),
          aria: { controls: @panel }, data: { action: SWITCH_ACTIONS }
        )
      end
    end
  end
end
