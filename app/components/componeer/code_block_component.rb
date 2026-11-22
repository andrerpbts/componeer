require "rouge"

module Componeer
  # Highlighted source code with a copy button. Rouge lexes it on the server: no JavaScript needed
  # for the colours. Pass the source as the first argument or as the block's text.
  class CodeBlockComponent < Component
    def initialize(source = nil, language: :plaintext, title: nil, copy: true, **html)
      @source, @language, @title, @copy, @html = source, language.to_s, title, copy, html
    end

    def call
      tag.figure(**html_attributes("tr-code", @html, data: { controller: "componeer--clipboard" })) do
        safe_join [ bar, tag.pre(tag.code(highlighted, data: { "componeer--clipboard-target": "source" }), class: "tr-code__pre") ]
      end
    end

    private
      def code
        (@source || content.to_s).to_str.strip_heredoc.strip
      end

      def lexer
        @lexer ||= Rouge::Lexer.find_fancy(@language, code) || Rouge::Lexers::PlainText.new
      end

      def highlighted
        Rouge::Formatters::HTML.new.format(lexer.lex(code)).html_safe
      end

      def bar
        tag.figcaption class: "tr-code__bar" do
          safe_join [
            tag.span(@title || lexer.class.title, class: "tr-code__title"),
            (copy_button if @copy)
          ].compact
        end
      end

      def copy_button
        tag.button(safe_join([ icon_svg("copy", size: 14), tag.span("Copiar", data: { "componeer--clipboard-target": "label" }) ]),
          type: "button", class: "tr-btn tr-btn--sm tr-btn--ghost", data: { action: "componeer--clipboard#copy" })
      end
  end
end
