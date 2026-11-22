module Componeer
  module Icon
    # Tabler icon (outline or filled), inlined so it takes the text colour.
    class Component < BaseComponent
      VARIANTS = %i[outline filled].freeze
      STROKE = {
        fill: "none", stroke: "currentColor", "stroke-width": 2,
        "stroke-linecap": "round", "stroke-linejoin": "round"
      }.freeze

      def initialize(name, size: 16, variant: :outline, label: nil, **html)
        @name = name
        @size = size
        @variant = option!(:variant, variant, VARIANTS)
        @label = label
        @html = html
      end

      private

      def paths
        Componeer::Icons.svg_body(@name, variant: @variant).html_safe
      end

      def attributes
        paint = @variant == :filled ? { fill: "currentColor" } : STROKE
        html_attributes "tr-icon", @html,
          width: @size, height: @size, viewBox: "0 0 24 24", **paint, **accessibility
      end

      def accessibility
        @label ? { role: "img", aria: { label: @label } } : { aria: { hidden: "true" } }
      end
    end
  end
end
