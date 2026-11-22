module Componeer
  module TabPanel
    # Content shown while the tab with panel: <id> is selected.
    class Component < BaseComponent
      def initialize(id:, selected: false, **html)
        @id = id
        @selected = selected
        @html = html
      end

      private

      def attributes
        html_attributes nil, @html,
          id: @id, role: "tabpanel", hidden: !@selected, tabindex: 0,
          aria: { labelledby: "#{@id}-tab" }
      end
    end
  end
end
