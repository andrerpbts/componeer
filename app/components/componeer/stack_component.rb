module Componeer
  # Vertical group of blocks with a fixed gap (16px by default).
  class StackComponent < Component
    def initialize(gap: nil, **html)
      @gap, @html = gap, html
    end

    def call
      tag.div content, **html_attributes("tr-stack", @html, style: ("gap: #{@gap}" if @gap))
    end
  end
end
