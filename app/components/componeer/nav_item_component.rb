module Componeer
  class NavItemComponent < Component
    def initialize(label, href:, icon: nil, current: nil, **html)
      @label, @href, @icon, @current, @html = label, href, icon, current, html
    end

    def call
      current = @current.nil? ? helpers.current_page?(@href) : @current
      link_to safe_join([ (icon_svg(@icon) if @icon), @label ].compact), @href,
        **html_attributes("tr-nav-item", @html, aria: { current: (current ? "page" : nil) })
    end
  end
end
