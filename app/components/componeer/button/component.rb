module Componeer
  module Button
    class Component < BaseComponent
      VARIANTS = %i[default primary danger danger_fill ghost].freeze
      SIZES = %i[md sm].freeze

      def initialize(label = nil, variant: :default, size: :md, icon: nil, href: nil,
        type: "button", **html)
        @label = label
        @variant = option!(:variant, variant, VARIANTS)
        @size = option!(:size, size, SIZES)
        @icon = icon
        @href = href
        @type = type
        @html = html
      end

      private

      def attributes
        classes = class_names "tr-btn",
          "tr-btn--#{@variant.to_s.dasherize}" => @variant != :default,
          "tr-btn--sm" => @size == :sm
        html_attributes(classes, @html)
      end
    end
  end
end
