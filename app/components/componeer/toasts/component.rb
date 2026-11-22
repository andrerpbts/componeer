module Componeer
  module Toasts
    # Bottom-right stack. Without a block it shows the flash:
    # notice as a toast, alert as an error toast.
    class Component < BaseComponent
      def initialize(flash: nil, **html)
        @flash = flash
        @html = html
      end

      private

      def flash_messages
        (@flash || helpers.flash).map do |type, message|
          [ message, type.to_s == "alert" ? :error : :default ]
        end
      end
    end
  end
end
