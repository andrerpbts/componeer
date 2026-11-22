module Componeer
  # The frame of every screen: optional environment banner, sidebar, scrolling main area (the block).
  class AppShellComponent < Component
    renders_one :banner, Componeer::EnvBannerComponent
    renders_one :sidebar, Componeer::SidebarComponent

    def initialize(**html)
      @html = html
    end
  end
end
