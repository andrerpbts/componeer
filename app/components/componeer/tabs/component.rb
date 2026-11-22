module Componeer
  module Tabs
    # Subsets of the same records. A tab with href: navigates; without it the tab switches on
    # the page (Stimulus), showing the tab_panel whose id it names in panel:.
    class Component < BaseComponent
      renders_many :tabs, Tab
      renders_many :actions

      def initialize(label:, **html)
        @label = label
        @html = html
      end
    end
  end
end
