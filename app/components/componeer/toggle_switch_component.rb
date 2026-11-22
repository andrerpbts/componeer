module Componeer
  # A real checkbox (it submits with forms) drawn as a switch.
  class ToggleSwitchComponent < Component
    def initialize(name, label:, checked: false, value: "1", **html)
      @name, @label, @checked, @value, @html = name, label, checked, value, html
    end

    def call
      tag.label class: "tr-switch-field" do
        safe_join [
          tag.input(**@html, type: "checkbox", role: "switch", name: @name, value: @value, checked: @checked, class: class_names("tr-sr-only", @html[:class])),
          tag.span(class: "tr-switch", aria: { hidden: "true" }),
          @label
        ]
      end
    end
  end
end
