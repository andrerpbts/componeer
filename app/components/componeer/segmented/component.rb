module Componeer
  module Segmented
    # Mutually exclusive views of the same data (Dia / Semana / Mês). Items without href:
    # switch on the page and dispatch componeer--segmented:change.
    class Component < BaseComponent
      renders_many :items, Item

      def initialize(label:, **html)
        @label = label
        @html = html
      end

      private

      def attributes
        html_attributes "tr-segmented", @html,
          role: "group", aria: { label: @label }, data: { controller: "componeer--segmented" }
      end
    end
  end
end
