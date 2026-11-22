module Componeer
  module Segmented
    # A link when it has href:, otherwise a button that switches on the page.
    class Item < BaseComponent
      def initialize(label, href: nil, pressed: false, value: nil, **html)
        @label = label
        @href = href
        @pressed = pressed
        @value = value || label
        @html = html
      end

      private

      def link_attributes
        html_attributes(nil, @html, aria: { current: ("page" if @pressed) })
      end

      def button_attributes
        html_attributes nil, @html,
          type: "button", value: @value, aria: { pressed: @pressed.to_s },
          data: { action: "componeer--segmented#select" }
      end
    end
  end
end
