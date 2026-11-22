module Componeer
  module Callout
    # Inline message: :info and :ok inform; :warning asks the person to act
    # and may carry one action.
    class Component < BaseComponent
      CLASSES = { info: "tr-notice", ok: "tr-notice tr-notice--ok", warning: "tr-help" }.freeze
      ICONS = { info: "info-circle", ok: "check", warning: "alert-triangle" }.freeze

      renders_one :action

      def initialize(text = nil, variant: :info, icon: nil, **html)
        @text = text
        @variant = option!(:variant, variant, CLASSES.keys)
        @icon = icon.nil? ? ICONS[@variant] : icon
        @html = html
      end

      private

      def attributes
        html_attributes(CLASSES[@variant], @html, role: @variant == :warning ? "alert" : "status")
      end
    end
  end
end
