module Componeer
  # One page of the docs icon gallery: a letter of the alphabet or the results of a search,
  # cut into pages of PER_PAGE icons.
  class IconGallery
    PER_PAGE = 240
    DIGITS = "0-9"

    attr_reader :variant, :query

    def initialize(variant: nil, letter: nil, query: nil, page: nil)
      @variant = variant.to_s == "filled" ? :filled : :outline
      @query = query.to_s.strip.downcase.tr("_ ", "--")
      @letter = letter.to_s
      @page = page.to_i
    end

    def letters
      @letters ||= all.group_by { |name| name.match?(/\A[a-z]/) ? name[0] : DIGITS }
        .sort_by { |letter, _| letter == DIGITS ? "~" : letter }.to_h
    end

    def letter
      letters.key?(@letter) ? @letter : letters.keys.first
    end

    def searching?
      query.present?
    end

    def matches
      @matches ||= searching? ? all.select { |name| name.include?(query) } : letters.fetch(letter)
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

    private
      def all
        Icons.names(variant: variant)
      end
  end
end
