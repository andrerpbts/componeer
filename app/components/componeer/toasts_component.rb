module Componeer
  # Bottom-right stack. Without a block it shows the flash: notice as a toast, alert as an error toast.
  class ToastsComponent < Component
    def initialize(flash: nil, **html)
      @flash, @html = flash, html
    end

    def call
      tag.div(**html_attributes("tr-toasts", @html, id: "toasts")) do
        content || safe_join(flash_toasts)
      end
    end

    private
      def flash_toasts
        (@flash || helpers.flash).map do |type, message|
          render ToastComponent.new(message, variant: (type.to_s == "alert" ? :error : :default))
        end
      end
  end
end
