module Componeer
  class BadgeComponent < Component
    def initialize(label = nil, **html)
      @label, @html = label, html
    end

    def call
      tag.span content || @label, **html_attributes("tr-badge", @html)
    end
  end
end
