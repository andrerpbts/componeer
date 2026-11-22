module Componeer
  # Subsets of the same records. A tab with href: navigates; without it, the tab switches on the page
  # (Stimulus), showing the tab_panel whose id it names in panel:.
  class TabsComponent < Component
    renders_many :tabs, ->(label, href: nil, count: nil, selected: false, panel: nil, **html) do
      body = safe_join([ label, (render(CounterComponent.new(count)) if count) ].compact)
      attributes = { class: "tr-tab", role: "tab", aria: { selected: selected.to_s } }.deep_merge(html)

      if href
        link_to(body, href, **attributes)
      else
        tag.button(body, type: "button", tabindex: (selected ? 0 : -1), id: ("#{panel}-tab" if panel),
          **attributes.deep_merge(aria: { controls: panel }, data: { action: "componeer--tabs#select keydown->componeer--tabs#navigate" }))
      end
    end
    renders_many :actions

    def initialize(label:, **html)
      @label, @html = label, html
    end

    def call
      tag.div(**html_attributes("tr-tabs-row", @html, data: { controller: "componeer--tabs" })) do
        safe_join [ tag.div(safe_join(tabs), class: "tr-tabs", role: "tablist", aria: { label: @label }), *actions ]
      end
    end
  end
end
