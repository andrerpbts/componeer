module Componeer
  # A page of the bundled documentation, read from config/docs.yml.
  class DocPage
    Section = Data.define(:heading, :text, :code, :language, :example, :gallery, :screen)
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

    def initialize(slug:, title:, group:, lead: nil, helper: nil, sections: [], options: [],
      slots: [])
      @slug = slug
      @title = title
      @group = group
      @lead = lead
      @helper = helper
      @sections = sections.map { |section| build_section(section) }
      @options = options.map { |name, description| Option.new(name:, description:) }
      @slots = slots.map { |name, description| Option.new(name:, description:) }
    end

    def to_param
      slug
    end

    private

    def build_section(section)
      Section.new(
        heading: section["heading"], text: section["text"], code: section["code"],
        language: section["language"] || "erb", example: section["example"],
        gallery: section["gallery"], screen: section["screen"]
      )
    end
  end
end
