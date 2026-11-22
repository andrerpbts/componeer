module Componeer
  # A page of the bundled documentation, read from config/docs.yml.
  class DocPage
    Section = Data.define(:heading, :text, :code, :example, :gallery, :screen)
    Option = Data.define(:name, :description)

    attr_reader :slug, :title, :group, :lead, :helper, :sections, :options, :slots

    class << self
      # Re-read when docs.yml changes, so edited docs show without restarting the server.
      def all
        path = Engine.root.join("config/docs.yml")
        @all = nil if @read_at != path.mtime
        @read_at = path.mtime
        @all ||= YAML.load_file(path).map { |attributes| new(**attributes.symbolize_keys) }
      end

      def find(slug)
        all.find { |page| page.slug == slug.to_s }
      end

      def grouped
        all.group_by(&:group)
      end

      def screens
        all.flat_map(&:sections).filter_map(&:screen)
      end
    end

    def initialize(slug:, title:, group:, lead: nil, helper: nil, sections: [], options: [], slots: [])
      @slug, @title, @group, @lead, @helper = slug, title, group, lead, helper
      @sections = sections.map { |s| Section.new(heading: s["heading"], text: s["text"], code: s["code"], example: s["example"], gallery: s["gallery"], screen: s["screen"]) }
      @options = options.map { |name, description| Option.new(name:, description:) }
      @slots = slots.map { |name, description| Option.new(name:, description:) }
    end

    def to_param
      slug
    end
  end
end
