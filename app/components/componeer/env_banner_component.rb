module Componeer
  # Names a non-real environment: :test (yellow) for test data, :sandbox (violet) for throwaway data.
  class EnvBannerComponent < Component
    KINDS = %i[test sandbox].freeze

    def initialize(text = nil, kind: :test, **html)
      @text, @kind, @html = text, kind.to_sym, html
      raise ArgumentError, "unknown kind #{kind.inspect}" unless KINDS.include?(@kind)
    end

    def call
      tag.div content || @text, **html_attributes(class_names("tr-env", "tr-env--sandbox" => @kind == :sandbox), @html, role: "note")
    end
  end
end
