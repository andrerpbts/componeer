module Componeer
  # Blocking dialog for confirmations and short forms. Footer: "Cancelar" first, the confirming action last.
  class ModalComponent < Component
    renders_one :footer

    def initialize(title:, subtitle: nil, close_href: nil, width: "440px", **html)
      @title, @subtitle, @close_href, @width, @html = title, subtitle, close_href, width, html
    end

    def title_id
      @title_id ||= "modal-#{object_id}"
    end
  end
end
