module Componeer
  module AppShell
    # The frame of every screen: optional environment banner, sidebar,
    # and the scrolling main area (the block).
    class Component < BaseComponent
      renders_one :banner, EnvBanner::Component
      renders_one :sidebar, Sidebar::Component

      def initialize(**html)
        @html = html
      end
    end
  end
end
