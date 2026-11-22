module Componeer
  class StatusPillComponent < Component
    STATUSES = { ok: :ok, bad: :bad, neutral: :neutral, accent: nil, warn: :warn }.freeze

    def initialize(label = nil, status: :ok, dot: true, **html)
      @label, @status, @dot, @html = label, status.to_sym, dot, html
      raise ArgumentError, "unknown status #{status.inspect}" unless STATUSES.key?(@status)
    end

    def call
      dot = render(StatusDotComponent.new(STATUSES[@status])) if @dot && STATUSES[@status]
      tag.span safe_join([ dot, content || @label ].compact), **html_attributes(pill_class, @html)
    end

    private
      def pill_class
        class_names("tr-pill", "tr-pill--#{@status}" => %i[bad neutral accent].include?(@status))
      end
  end
end
