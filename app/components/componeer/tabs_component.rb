module Componeer
  class TabsComponent < Component
    renders_many :tabs, ->(label, href: nil, count: nil, selected: false, **html) do
      body = safe_join([ label, (render(CounterComponent.new(count)) if count) ].compact)
      attributes = { class: "tr-tab", role: "tab", aria: { selected: selected.to_s } }.deep_merge(html)

      href ? link_to(body, href, **attributes) : tag.button(body, type: "button", **attributes)
    end
    renders_many :actions

    def initialize(label:, **html)
      @label, @html = label, html
    end

    def call
      tag.div(**html_attributes("tr-tabs-row", @html)) do
        safe_join [ tag.div(safe_join(tabs), class: "tr-tabs", role: "tablist", aria: { label: @label }), *actions ]
      end
    end
  end
end
