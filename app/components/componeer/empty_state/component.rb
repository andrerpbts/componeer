module Componeer
  module EmptyState
    # Says what is empty in the list's own terms and, when there is one, the way out.
    class Component < BaseComponent
      SIZES = %i[md sm].freeze

      renders_many :actions

      def initialize(title = nil, description: nil, icon: nil, size: :md, bordered: false,
        **html)
        @title = title
        @description = description
        @icon = icon
        @size = option!(:size, size, SIZES)
        @bordered = bordered
        @html = html
      end

      private

      def attributes
        classes = class_names "tr-empty-state",
          "tr-empty-state--sm" => @size == :sm,
          "tr-empty-state--bordered" => @bordered
        html_attributes(classes, @html, role: "status")
      end

      def icon_size
        @size == :sm ? 18 : 24
      end
    end
  end
end
