module Componeer
  class EmptyStateComponent < Component
    def initialize(text = nil, **html)
      @text, @html = text, html
    end

    def call
      tag.p content || @text, **html_attributes("tr-empty", @html)
    end
  end
end
