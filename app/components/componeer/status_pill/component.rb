module Componeer
  module StatusPill
    class Component < BaseComponent
      # Pill status => dot status (accent has no dot).
      DOTS = { ok: :ok, bad: :bad, neutral: :neutral, accent: nil, warn: :warn }.freeze
      TINTED = %i[bad neutral accent].freeze

      def initialize(label = nil, status: :ok, dot: true, **html)
        @label = label
        @status = option!(:status, status, DOTS.keys)
        @dot = dot
        @html = html
      end

      private

      def dot_status
        DOTS[@status] if @dot
      end

      def attributes
        html_attributes(class_names("tr-pill", "tr-pill--#{@status}" => TINTED.include?(@status)),
@html)
      end
    end
  end
end
