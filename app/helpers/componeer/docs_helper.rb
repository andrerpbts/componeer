module Componeer
  module DocsHelper
    EXAMPLES = Engine.root.join("app/views/componeer/docs/examples")
    SCREENS = Engine.root.join("app/views/componeer/screens")

    def example_source(name)
      File.read(EXAMPLES.join("_#{name}.html.erb")).strip
    end

    def screen_source(name)
      File.read(SCREENS.join("_#{name}.html.erb")).strip
    end

    # The helper call the icon gallery copies when an icon is clicked.
    def icon_code(name, variant)
      variant == :filled ? %(icon "#{name}", variant: :filled) : %(icon "#{name}")
    end

    # Paragraphs split on blank lines, each a list of [text, code?] parts (`code` in backticks).
    def doc_paragraphs(text)
      text.to_s.split(/\n{2,}/).map do |paragraph|
        paragraph.split(/(`[^`]+`)/).map do |part|
          part.start_with?("`") ? [ part[1..-2], true ] : [ part, false ]
        end
      end
    end
  end
end
