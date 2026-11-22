module Componeer
  module NavItem
    class Component < BaseComponent
      def initialize(label, href:, icon: nil, current: nil, **html)
        @label = label
        @href = href
        @icon = icon
        @current = current
        @html = html
      end

      private

      def current?
        @current.nil? ? helpers.current_page?(@href) : @current
      end

      def attributes
        html_attributes("tr-nav-item", @html, aria: { current: ("page" if current?) })
      end
    end
  end
end
