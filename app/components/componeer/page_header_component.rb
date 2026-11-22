module Componeer
  # Title row (title, one context line, actions), optional filters row and tabs row.
  class PageHeaderComponent < Component
    renders_many :actions
    renders_one :filters
    renders_one :tabs, Componeer::TabsComponent

    def initialize(title:, subtitle: nil, **html)
      @title, @subtitle, @html = title, subtitle, html
    end
  end
end
