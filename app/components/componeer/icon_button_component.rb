module Componeer
  class IconButtonComponent < Component
    def initialize(icon, label:, variant: :ghost, href: nil, type: "button", **html)
      @icon, @label, @variant, @href, @type, @html = icon, label, variant.to_sym, href, type, html
    end

    def call
      classes = class_names("tr-btn tr-btn--icon", "tr-btn--ghost" => @variant == :ghost, "tr-btn--danger" => @variant == :danger)
      attributes = html_attributes(classes, @html, aria: { label: @label }, title: @label)

      if @href
        link_to icon_svg(@icon), @href, **attributes
      else
        tag.button icon_svg(@icon), **attributes, type: @type
      end
    end
  end
end
