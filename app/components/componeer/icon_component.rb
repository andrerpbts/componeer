module Componeer
  # Tabler icon (outline or filled), inlined so it takes the text colour.
  class IconComponent < Component
    def initialize(name, size: 16, variant: :outline, label: nil, **html)
      @name, @size, @variant, @label, @html = name, size, variant.to_sym, label, html
    end

    def call
      tag.svg Componeer::Icons.svg_body(@name, variant: @variant).html_safe, **html_attributes("tr-icon", @html, **svg_attributes)
    end

    private
      def svg_attributes
        accessibility = @label ? { role: "img", aria: { label: @label } } : { aria: { hidden: "true" } }
        { width: @size, height: @size, viewBox: "0 0 24 24", **paint, **accessibility }
      end

      def paint
        if @variant == :filled
          { fill: "currentColor" }
        else
          { fill: "none", stroke: "currentColor", "stroke-width": 2, "stroke-linecap": "round", "stroke-linejoin": "round" }
        end
      end
  end
end
