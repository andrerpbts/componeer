module Componeer
  module Drawer
    # A record's detail on the right edge, over the list it came from.
    # Escape or the close button leaves it.
    class Component < BaseComponent
      renders_one :meta
      renders_many :actions
      renders_many :sections, Section

      def initialize(title:, close_href: nil, eyebrow: nil, **html)
        @title = title
        @close_href = close_href
        @eyebrow = eyebrow
        @html = html
      end
    end
  end
end
