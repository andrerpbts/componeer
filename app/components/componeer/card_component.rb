module Componeer
  class CardComponent < Component
    renders_many :actions
    renders_one :footer

    def initialize(title: nil, subtitle: nil, flush: false, **html)
      @title, @subtitle, @flush, @html = title, subtitle, flush, html
    end

    def header?
      @title || @subtitle || actions?
    end
  end
end
