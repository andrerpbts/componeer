module Componeer
  class StatusDotComponent < Component
    STATUSES = %i[neutral ok warn bad].freeze

    def initialize(status = :neutral, color: nil, **html)
      @status, @color, @html = status.to_sym, color, html
      raise ArgumentError, "unknown status #{status.inspect}" unless STATUSES.include?(@status)
    end

    def call
      style = "background: #{@color}" if @color
      tag.span(**html_attributes(class_names("tr-dot", "tr-dot--#{@status}" => @status != :neutral), @html, aria: { hidden: "true" }, style: style))
    end
  end
end
