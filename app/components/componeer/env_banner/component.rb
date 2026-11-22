module Componeer
  module EnvBanner
    # Names an environment that is not the real one:
    # :test (yellow) for test data, :sandbox (violet) for throwaway data.
    class Component < BaseComponent
      KINDS = %i[test sandbox].freeze

      def initialize(text = nil, kind: :test, **html)
        @text = text
        @kind = option!(:kind, kind, KINDS)
        @html = html
      end

      private

      def attributes
        html_attributes(class_names("tr-env", "tr-env--sandbox" => @kind == :sandbox), @html,
role: "note")
      end
    end
  end
end
