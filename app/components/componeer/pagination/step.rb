module Componeer
  module Pagination
    # The previous or next arrow: a link when that page exists, a disabled mark when it doesn't.
    class Step < BaseComponent
      def initialize(page:, pages:, url:, icon:, label:, rel:)
        @page = page
        @pages = pages
        @url = url
        @icon = icon
        @label = label
        @rel = rel
      end

      private

      def available?
        @page.between?(1, @pages)
      end
    end
  end
end
