module Componeer
  module SearchInput
    class Component < BaseComponent
      def initialize(name: :q, value: nil, placeholder: "Buscar", label: nil, **html)
        @name = name
        @value = value
        @placeholder = placeholder
        @label = label || placeholder
        @html = html
      end

      private

      def input_attributes
        html_attributes "tr-input", @html,
          type: "search", name: @name, value: @value, placeholder: @placeholder,
          aria: { label: @label }
      end
    end
  end
end
