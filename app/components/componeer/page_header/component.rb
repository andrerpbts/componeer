module Componeer
  module PageHeader
    # Title row (title, one context line, actions), optional filters row and tabs row.
    class Component < BaseComponent
      renders_many :actions
      renders_one :filters
      renders_one :tabs, Tabs::Component

      def initialize(title:, subtitle: nil, **html)
        @title = title
        @subtitle = subtitle
        @html = html
      end
    end
  end
end
