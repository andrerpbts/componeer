module Componeer
  module Stack
    # Vertical group of blocks with a fixed gap (16px by default).
    class Component < BaseComponent
      def initialize(gap: nil, **html)
        @gap = gap
        @html = html
      end

      private

      def attributes
        html_attributes("tr-stack", @html, style: ("gap: #{@gap}" if @gap))
      end
    end
  end
end
