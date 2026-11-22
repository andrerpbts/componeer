module Componeer
  module StatusDot
    class Component < BaseComponent
      STATUSES = %i[neutral ok warn bad].freeze

      def initialize(status = :neutral, color: nil, **html)
        @status = option!(:status, status, STATUSES)
        @color = color
        @html = html
      end

      private

      def attributes
        classes = class_names("tr-dot", "tr-dot--#{@status}" => @status != :neutral)
        style = "background: #{@color}" if @color
        html_attributes(classes, @html, aria: { hidden: "true" }, style: style)
      end
    end
  end
end
