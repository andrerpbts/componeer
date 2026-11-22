module Componeer
  # Mutually exclusive views of the same data (Dia / Semana / Mês). Items are links or buttons.
  class SegmentedComponent < Component
    renders_many :items, ->(label, href: nil, pressed: false, **html) do
      if href
        link_to label, href, **html, aria: { current: (pressed ? "page" : nil) }
      else
        tag.button label, **html, type: "button", aria: { pressed: pressed.to_s }
      end
    end

    def initialize(label:, **html)
      @label, @html = label, html
    end

    def call
      tag.div safe_join(items), **html_attributes("tr-segmented", @html, role: "group", aria: { label: @label })
    end
  end
end
