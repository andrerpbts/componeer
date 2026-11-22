module Componeer
  class CounterComponent < Component
    def initialize(value, **html)
      @value, @html = value, html
    end

    def call
      tag.span helpers.number_with_delimiter(@value), **html_attributes("tr-count", @html)
    end
  end
end
