module Componeer
  class SearchInputComponent < Component
    def initialize(name: :q, value: nil, placeholder: "Buscar", label: nil, **html)
      @name, @value, @placeholder, @label, @html = name, value, placeholder, label || placeholder, html
    end

    def call
      tag.div class: "tr-search" do
        safe_join [
          icon_svg("search"),
          tag.input(**html_attributes("tr-input", @html, type: "search", name: @name, value: @value,
            placeholder: @placeholder, aria: { label: @label }))
        ]
      end
    end
  end
end
