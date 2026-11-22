module Componeer
  class ButtonComponent < Component
    VARIANTS = %i[default primary danger danger_fill ghost].freeze
    SIZES = %i[md sm].freeze

    def initialize(label = nil, variant: :default, size: :md, icon: nil, href: nil, type: "button", **html)
      @label, @variant, @size, @icon, @href, @type, @html = label, variant.to_sym, size.to_sym, icon, href, type, html
      raise ArgumentError, "unknown variant #{variant.inspect}" unless VARIANTS.include?(@variant)
      raise ArgumentError, "unknown size #{size.inspect}" unless SIZES.include?(@size)
    end

    def call
      body = safe_join([ (icon_svg(@icon) if @icon), (content || @label) ].compact)

      if @href
        link_to body, @href, **html_attributes(classes, @html)
      else
        tag.button body, **html_attributes(classes, @html, type: @type)
      end
    end

    private
      def classes
        class_names("tr-btn", "tr-btn--#{@variant.to_s.dasherize}" => @variant != :default, "tr-btn--sm" => @size == :sm)
      end
  end
end
