module Componeer
  # Horizontal, wrapping group of inline items (buttons, pills) with an 8px gap.
  class ClusterComponent < Component
    def initialize(gap: nil, **html)
      @gap, @html = gap, html
    end

    def call
      tag.div content, **html_attributes("tr-cluster", @html, style: ("gap: #{@gap}" if @gap))
    end
  end
end
