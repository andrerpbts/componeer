module Componeer
  module DocsHelper
    EXAMPLES = Engine.root.join("app/views/componeer/docs/examples")
    SCREENS = Engine.root.join("app/views/componeer/screens")

    def self.icon_grids
      @icon_grids ||= {}
    end

    def screen_source(name)
      File.read(SCREENS.join("_#{name}.html.erb")).strip
    end

    # Renders an example partial and shows its ERB source next to it.
    def doc_example(name)
      source = File.read(EXAMPLES.join("_#{name}.html.erb"))
      tag.figure class: "doc-example" do
        safe_join [
          tag.div(render("componeer/docs/examples/#{name}"), class: "doc-example__preview tr-root"),
          tag.pre(tag.code(source.strip), class: "doc-code")
        ]
      end
    end

    # Every bundled Tabler icon of a variant as copy-on-click tiles. Built as one string and
    # memoized: thousands of component renders would make the page slow.
    def icon_gallery_grid(variant, hidden: false)
      grid = DocsHelper.icon_grids[variant] ||= Componeer::Icons.names(variant: variant).map do |name|
        code = variant == :filled ? %(icon "#{name}", variant: :filled) : %(icon "#{name}")
        svg = render(Componeer::IconComponent.new(name, size: 24, variant: variant))
        %(<button type="button" class="doc-icon" title="#{name}" data-name="#{name}" data-code="#{ERB::Util.html_escape(code)}" data-action="docs-icons#copy">#{svg}<span>#{name}</span></button>)
      end.join.html_safe
      tag.div grid, class: "doc-icon-grid", hidden: hidden, data: { "docs-icons-target": "grid", variant: variant }
    end

    # Paragraphs separated by blank lines; `code` spans in backticks.
    def doc_text(text)
      safe_join(text.to_s.split(/\n{2,}/).map do |paragraph|
        tag.p(safe_join(paragraph.split(/(`[^`]+`)/).map { |part| part.start_with?("`") ? tag.code(part[1..-2]) : part }))
      end)
    end
  end
end
