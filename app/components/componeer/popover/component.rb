module Componeer
  module Popover
    # A trigger plus a floating panel; the panel closes on Escape and on a click outside.
    class Component < BaseComponent
      ALIGNS = %i[left right].freeze

      renders_one :trigger

      def initialize(align: :left, **html)
        @align = option!(:align, align, ALIGNS)
        @html = html
      end

      private

      def panel_classes
        class_names("tr-popover__panel", "tr-popover__panel--right" => @align == :right)
      end
    end
  end
end
