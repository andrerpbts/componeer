module Componeer
  module Cluster
    # Horizontal, wrapping group of inline items (buttons, pills) with an 8px gap.
    class Component < BaseComponent
      def initialize(gap: nil, **html)
        @gap = gap
        @html = html
      end

      private

      def attributes
        html_attributes("tr-cluster", @html, style: ("gap: #{@gap}" if @gap))
      end
    end
  end
end
