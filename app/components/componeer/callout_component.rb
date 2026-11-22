module Componeer
  # Inline message: :info and :ok inform, :warning asks the person to act and may carry one action.
  class CalloutComponent < Component
    VARIANTS = { info: "tr-notice", ok: "tr-notice tr-notice--ok", warning: "tr-help" }.freeze
    ICONS = { info: "info-circle", ok: "check", warning: "alert-triangle" }.freeze

    renders_one :action

    def initialize(text = nil, variant: :info, icon: nil, **html)
      @text, @variant, @html = text, variant.to_sym, html
      raise ArgumentError, "unknown variant #{variant.inspect}" unless VARIANTS.key?(@variant)
      @icon = icon.nil? ? ICONS[@variant] : icon
    end

    def call
      tag.div safe_join([ (icon_svg(@icon) if @icon), tag.span(content || @text, style: "flex: 1"), action ].compact),
        **html_attributes(VARIANTS[@variant], @html, role: (@variant == :warning ? "alert" : "status"))
    end
  end
end
