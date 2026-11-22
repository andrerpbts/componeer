module Componeer
  # Tabler outline icon, inlined so it takes the text colour.
  class IconComponent < Component
    def initialize(name, size: 16, label: nil, **html)
      @name, @size, @label, @html = name, size, label, html
    end

    def call
      tag.svg Componeer::Icons.svg_body(@name).html_safe, **html_attributes("tr-icon", @html, **svg_attributes)
    end

    private
      def svg_attributes
        accessibility = @label ? { role: "img", aria: { label: @label } } : { aria: { hidden: "true" } }
        { width: @size, height: @size, viewBox: "0 0 24 24", fill: "none", stroke: "currentColor",
          "stroke-width": 2, "stroke-linecap": "round", "stroke-linejoin": "round", **accessibility }
      end
  end
end
