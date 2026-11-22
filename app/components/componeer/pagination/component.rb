module Componeer
  module Pagination
    # Page links: previous, first, a window around the current page, last, next.
    #   pagination(page: 3, pages: 12, url: ->(page) { notes_path(page:) })
    class Component < BaseComponent
      WINDOW = 2

      def initialize(page:, pages:, url:, label: "Paginação", **html)
        @pages = pages.to_i
        @page = page.to_i.clamp(1, [ @pages, 1 ].max)
        @url = url
        @label = label
        @html = html
      end

      def render?
        @pages > 1
      end

      private

      # Page numbers to show, with :gap where pages are skipped: [1, :gap, 5, 6, 7, 8, 9, :gap, 24].
      def numbers
        shown = ([ 1, @pages ] + ((@page - WINDOW)..(@page + WINDOW)).to_a)
          .select { |page| page.between?(1, @pages) }.uniq.sort

        shown.each_cons(2).flat_map { |a, b| b - a > 1 ? [ a, :gap ] : [ a ] } + [ shown.last ]
      end

      def previous_step
        Step.new(page: @page - 1, pages: @pages, url: @url,
          icon: "chevron-left", label: "Página anterior", rel: "prev")
      end

      def next_step
        Step.new(page: @page + 1, pages: @pages, url: @url,
          icon: "chevron-right", label: "Próxima página", rel: "next")
      end
    end
  end
end
