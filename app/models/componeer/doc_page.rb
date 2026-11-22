module Componeer
  # A page of the bundled documentation, read from config/docs.yml.
  class DocPage
    Section = Data.define(:heading, :text, :code, :example)
    Option = Data.define(:name, :description)

    attr_reader :slug, :title, :group, :lead, :helper, :sections, :options, :slots

    class << self
      def all
        @all ||= YAML.load_file(Engine.root.join("config/docs.yml")).map { |attributes| new(**attributes.symbolize_keys) }
      end

      def find(slug)
        all.find { |page| page.slug == slug.to_s }
      end

      def grouped
        all.group_by(&:group)
      end
    end

    def initialize(slug:, title:, group:, lead: nil, helper: nil, sections: [], options: [], slots: [])
      @slug, @title, @group, @lead, @helper = slug, title, group, lead, helper
      @sections = sections.map { |s| Section.new(heading: s["heading"], text: s["text"], code: s["code"], example: s["example"]) }
      @options = options.map { |name, description| Option.new(name:, description:) }
      @slots = slots.map { |name, description| Option.new(name:, description:) }
    end

    def to_param
      slug
    end
  end
end
