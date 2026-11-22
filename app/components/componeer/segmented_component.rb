module Componeer
  # Mutually exclusive views of the same data (Dia / Semana / Mês). Items with href: are links;
  # without it they are buttons that switch on the page and dispatch componeer--segmented:change.
  class SegmentedComponent < Component
    renders_many :items, ->(label, href: nil, pressed: false, value: nil, **html) do
      if href
        link_to label, href, **html, aria: { current: (pressed ? "page" : nil) }
      else
        tag.button label, **html, type: "button", value: value || label, aria: { pressed: pressed.to_s },
          data: { action: "componeer--segmented#select" }.merge(html.fetch(:data, {}))
      end
    end

    def initialize(label:, **html)
      @label, @html = label, html
    end

    def call
      tag.div safe_join(items), **html_attributes("tr-segmented", @html, role: "group", aria: { label: @label },
        data: { controller: "componeer--segmented" })
    end
  end
end
