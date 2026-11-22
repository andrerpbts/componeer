module Componeer
  # A trigger plus a floating panel; the panel closes on Escape and on a click outside.
  class PopoverComponent < Component
    renders_one :trigger

    def initialize(align: :left, **html)
      @align, @html = align.to_sym, html
    end

    def call
      tag.div(**html_attributes("tr-popover", @html, data: { controller: "componeer--popover" })) do
        safe_join [
          tag.span(trigger, data: { action: "click->componeer--popover#toggle", "componeer--popover-target": "trigger" }, style: "display: contents"),
          tag.div(content, hidden: true, class: class_names("tr-popover__panel", "tr-popover__panel--right" => @align == :right),
            data: { "componeer--popover-target": "panel" })
        ]
      end
    end
  end
end
