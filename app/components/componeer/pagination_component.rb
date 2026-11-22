module Componeer
  # Page links: previous, first, a window around the current page, last, next.
  #   pagination(page: 3, pages: 12, url: ->(page) { notes_path(page:) })
  class PaginationComponent < Component
    WINDOW = 2

    def initialize(page:, pages:, url:, label: "Paginação", **html)
      @page, @pages, @url, @label, @html = page.to_i.clamp(1, [ pages.to_i, 1 ].max), pages.to_i, url, label, html
    end

    def render?
      @pages > 1
    end

    def call
      tag.nav(**html_attributes("tr-pagination", @html, aria: { label: @label })) do
        safe_join [ step(@page - 1, "chevron-left", "Página anterior"), *numbers, step(@page + 1, "chevron-right", "Próxima página") ]
      end
    end

    private
      def numbers
        shown = ([ 1, @pages ] + ((@page - WINDOW)..(@page + WINDOW)).to_a).select { |p| p.between?(1, @pages) }.uniq.sort
        shown.each_cons(2).flat_map { |a, b| b - a > 1 ? [ a, :gap ] : [ a ] }.push(shown.last).map do |page|
          page == :gap ? tag.span("…", class: "tr-pagination__gap", aria: { hidden: "true" }) : number(page)
        end
      end

      def number(page)
        link_to page, @url.call(page), class: "tr-btn tr-btn--sm", aria: { current: (page == @page ? "page" : nil), label: "Página #{page}" }
      end

      def step(page, icon, label)
        if page.between?(1, @pages)
          link_to icon_svg(icon), @url.call(page), class: "tr-btn tr-btn--sm tr-btn--icon", aria: { label: label }, rel: (page < @page ? "prev" : "next")
        else
          tag.span icon_svg(icon), class: "tr-btn tr-btn--sm tr-btn--icon", aria: { disabled: "true", label: label }
        end
      end
  end
end
