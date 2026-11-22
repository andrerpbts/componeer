module Componeer
  # Content shown when the tab with panel: <id> is selected.
  class TabPanelComponent < Component
    def initialize(id:, selected: false, **html)
      @id, @selected, @html = id, selected, html
    end

    def call
      tag.div content, **html_attributes(nil, @html, id: @id, role: "tabpanel", hidden: !@selected,
        tabindex: 0, aria: { labelledby: "#{@id}-tab" })
    end
  end
end
