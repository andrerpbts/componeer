module Componeer
  # A record's detail on the right edge, over the list it came from. Escape or the close button leaves it.
  class DrawerComponent < Component
    renders_one :meta
    renders_many :actions
    renders_many :sections, ->(title = nil, **html, &block) do
      tag.section(**{ class: "tr-drawer__section" }.merge(html)) do
        safe_join [ (tag.h2(title) if title), capture(&block) ].compact
      end
    end

    def initialize(title:, close_href: nil, eyebrow: nil, **html)
      @title, @close_href, @eyebrow, @html = title, close_href, eyebrow, html
    end
  end
end
