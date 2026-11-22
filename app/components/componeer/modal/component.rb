module Componeer
  module Modal
    # Blocking dialog for confirmations and short forms.
    # Footer: "Cancelar" first, the confirming action last.
    class Component < BaseComponent
      renders_one :footer

      def initialize(title:, subtitle: nil, close_href: nil, width: "440px", **html)
        @title = title
        @subtitle = subtitle
        @close_href = close_href
        @width = width
        @html = html
      end

      def title_id
        @title_id ||= "modal-#{object_id}"
      end
    end
  end
end
