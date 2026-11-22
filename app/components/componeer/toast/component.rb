module Componeer
  module Toast
    class Component < BaseComponent
      VARIANTS = %i[default error].freeze

      renders_one :action

      def initialize(message = nil, variant: :default, dismiss_after: 6000, **html)
        @message = message
        @variant = option!(:variant, variant, VARIANTS)
        @dismiss_after = dismiss_after
        @html = html
      end

      private

      def attributes
        html_attributes class_names("tr-toast", "tr-toast--error" => @variant == :error), @html,
          role: @variant == :error ? "alert" : "status",
          data: {
            controller: "componeer--dismissable",
            "componeer--dismissable-after-value": @dismiss_after
          }
      end
    end
  end
end
