module Componeer
  # One page of the docs icon gallery. Search, letter, variant and page combine: a letter narrows
  # the search results, and every link keeps the other filters.
  class IconGallery
    PER_PAGE = 120
    DIGITS = "0-9"

    attr_reader :variant, :query

    def initialize(variant: nil, letter: nil, query: nil, page: nil)
      @variant = variant.to_s == "filled" ? :filled : :outline
      @query = query.to_s.strip.downcase.tr("_ ", "--")
      @letter = letter.to_s
      @page = page.to_i
    end

    def searching?
      query.present?
    end

    # Every letter of the set with how many icons match the search under it (0 when none do).
    def letters
      @letters ||= begin
        counts = found.group_by { |name| letter_of(name) }.transform_values(&:size)
        all.map { |name| letter_of(name) }.uniq.sort_by { |letter| letter == DIGITS ? "~" : letter }.index_with { |letter| counts.fetch(letter, 0) }
      end
    end

    # The chosen letter; without one, a search spans every letter and browsing starts at the first.
    def letter
      return @letter if letters.key?(@letter)

      searching? ? nil : letters.keys.first
    end

    def matches
      @matches ||= letter ? found.select { |name| letter_of(name) == letter } : found
    end

    def pages
      [ (matches.size / PER_PAGE.to_f).ceil, 1 ].max
    end

    def page
      @page.clamp(1, pages)
    end

    def names
      matches.slice((page - 1) * PER_PAGE, PER_PAGE) || []
    end

    def count(variant)
      Icons.names(variant: variant).size
    end

    # Query params for a link that changes some filters and keeps the rest.
    def params_with(**changes)
      { variant: variant, q: query.presence, letter: letter, page: nil }.merge(changes).compact
    end

    private
      def all
        Icons.names(variant: variant)
      end

      def found
        @found ||= searching? ? all.select { |name| name.include?(query) } : all
      end

      def letter_of(name)
        name.match?(/\A[a-z]/) ? name[0] : DIGITS
      end
  end
end
