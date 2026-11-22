require "rouge"

module Componeer
  module CodeBlock
    # Highlighted source code with a copy button. Rouge lexes it on the server, so the colours
    # need no JavaScript. Pass the source as the first argument or as the block's text.
    class Component < BaseComponent
      def initialize(source = nil, language: :plaintext, title: nil, copy: true, **html)
        @source = source
        @language = language.to_s
        @title = title
        @copy = copy
        @html = html
      end

      private

      def code
        @code ||= (@source || content.to_s).to_str.strip_heredoc.strip
      end

      def lexer
        @lexer ||= Rouge::Lexer.find_fancy(@language, code) || Rouge::Lexers::PlainText.new
      end

      def highlighted
        Rouge::Formatters::HTML.new.format(lexer.lex(code)).html_safe
      end

      def title
        @title || lexer.class.title
      end
    end
  end
end
