module Componeer
  class ToastComponent < Component
    renders_one :action

    def initialize(message = nil, variant: :default, dismiss_after: 6000, **html)
      @message, @variant, @dismiss_after, @html = message, variant.to_sym, dismiss_after, html
    end

    def call
      close = render(IconButtonComponent.new("x", label: "Fechar", data: { action: "componeer--dismissable#dismiss" }))
      tag.div safe_join([ tag.span(content || @message), action, close ].compact),
        **html_attributes(class_names("tr-toast", "tr-toast--error" => @variant == :error), @html,
          role: (@variant == :error ? "alert" : "status"),
          data: { controller: "componeer--dismissable", "componeer--dismissable-after-value": @dismiss_after })
    end
  end
end
