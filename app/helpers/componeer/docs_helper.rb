module Componeer
  module DocsHelper
    EXAMPLES = Engine.root.join("app/views/componeer/docs/examples")

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

    # Paragraphs separated by blank lines; `code` spans in backticks.
    def doc_text(text)
      safe_join(text.to_s.split(/\n{2,}/).map do |paragraph|
        tag.p(safe_join(paragraph.split(/(`[^`]+`)/).map { |part| part.start_with?("`") ? tag.code(part[1..-2]) : part }))
      end)
    end
  end
end
