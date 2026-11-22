module Componeer
  module IconButton
    class Component < BaseComponent
      VARIANTS = %i[default ghost danger].freeze

      def initialize(icon, label:, variant: :ghost, href: nil, type: "button", **html)
        @icon = icon
        @label = label
        @variant = option!(:variant, variant, VARIANTS)
        @href = href
        @type = type
        @html = html
      end

      private

      def attributes
        classes = class_names "tr-btn tr-btn--icon",
          "tr-btn--ghost" => @variant == :ghost,
          "tr-btn--danger" => @variant == :danger
        html_attributes(classes, @html, aria: { label: @label }, title: @label)
      end
    end
  end
end
