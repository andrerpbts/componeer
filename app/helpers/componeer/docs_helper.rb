module Componeer
  module DocsHelper
    EXAMPLES = Engine.root.join("app/views/componeer/docs/examples")
    SCREENS = Engine.root.join("app/views/componeer/screens")

    def screen_source(name)
      File.read(SCREENS.join("_#{name}.html.erb")).strip
    end

    # Renders an example partial with Preview and Source tabs.
    def doc_example(name)
      doc_tabs("example-#{name.dasherize}",
        preview: tag.div(render("componeer/docs/examples/#{name}"), class: "doc-example__preview tr-root"),
        source: File.read(EXAMPLES.join("_#{name}.html.erb")))
    end

    def doc_tabs(id, preview:, source:)
      tag.figure class: "doc-example" do
        safe_join [
          render(Componeer::TabsComponent.new(label: "Example", class: "doc-example__tabs")) do |tabs|
            tabs.with_tab "Preview", selected: true, panel: "#{id}-preview"
            tabs.with_tab "Source", panel: "#{id}-source"
            nil
          end,
          render(Componeer::TabPanelComponent.new(id: "#{id}-preview", selected: true)) { preview },
          render(Componeer::TabPanelComponent.new(id: "#{id}-source", class: "doc-example__source")) do
            code_block(source.strip, language: :erb, title: "ERB")
          end
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
