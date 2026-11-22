module Componeer
  module DocsHelper
    EXAMPLES = Engine.root.join("app/views/componeer/docs/examples")
    SCREENS = Engine.root.join("app/views/componeer/screens")

    def screen_source(name)
      File.read(SCREENS.join("_#{name}.html.erb")).strip
    end

    # Renders an example partial and shows its ERB source next to it.
    def doc_example(name)
      source = File.read(EXAMPLES.join("_#{name}.html.erb"))
      tag.figure class: "doc-example" do
        safe_join [
          tag.div(render("componeer/docs/examples/#{name}"), class: "doc-example__preview tr-root"),
          code_block(source, language: :erb, title: "ERB", class: "doc-example__code")
        ]
      end
    end

    # Copy-on-click tiles for a page of the icon gallery.
    def icon_gallery_grid(names, variant:)
      tiles = names.map do |name|
        code = variant == :filled ? %(icon "#{name}", variant: :filled) : %(icon "#{name}")
        tag.button(safe_join([ render(Componeer::IconComponent.new(name, size: 24, variant: variant)), tag.span(name) ]),
          type: "button", class: "doc-icon", title: name, data: { code: code, action: "docs-icons#copy" })
      end
      tag.div safe_join(tiles), class: "doc-icon-grid"
    end

    # Paragraphs separated by blank lines; `code` spans in backticks.
    def doc_text(text)
      safe_join(text.to_s.split(/\n{2,}/).map do |paragraph|
        tag.p(safe_join(paragraph.split(/(`[^`]+`)/).map { |part| part.start_with?("`") ? tag.code(part[1..-2]) : part }))
      end)
    end
  end
end
