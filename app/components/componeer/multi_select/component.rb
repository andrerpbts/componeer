module Componeer
  module MultiSelect
    # Filter by several values of one dimension. Submits name[] with the checked values;
    # all checked and none checked are both shown explicitly to the person.
    class Component < BaseComponent
      Option = Data.define(:value, :label, :sub, :status, :color)

      def initialize(name:, label:, options:, selected: nil, icon: nil,
        all_label: "Todos", none_label: "Nenhum", many_label: "%{count} selecionados",
        searchable: nil, search_placeholder: "Buscar", align: :left, **html)
        @name = name
        @label = label
        @options = options.map { |option| build_option(option) }
        @selected = selected.nil? ? @options.map(&:value) : Array(selected).map(&:to_s)
        @icon = icon
        @all_label = all_label
        @none_label = none_label
        @many_label = many_label
        @searchable = searchable.nil? ? @options.size > 8 : searchable
        @search_placeholder = search_placeholder
        @align = align
        @html = html
      end

      def summary
        chosen = @options.select { |option| checked?(option) }

        if chosen.size == @options.size then @all_label
        elsif chosen.empty? then @none_label
        elsif chosen.one? then chosen.first.label
        else format(@many_label, count: chosen.size)
        end
      end

      def checked?(option)
        @selected.include?(option.value)
      end

      def all_checked?
        @options.all? { |option| checked?(option) }
      end

      def controller_data
        {
          controller: "componeer--multi-select",
          "componeer--multi-select-all-label-value": @all_label,
          "componeer--multi-select-none-label-value": @none_label,
          "componeer--multi-select-many-label-value": @many_label
        }
      end

      private
      def build_option(option)
        option = { value: option, label: option } unless option.is_a?(Hash)

        Option.new(
          value: option.fetch(:value).to_s, label: option.fetch(:label),
          sub: option[:sub], status: option[:status], color: option[:color]
        )
      end
    end
  end
end
