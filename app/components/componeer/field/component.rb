module Componeer
  module Field
    # Label + control + hint or error. The block is the control
    # (text_field_tag, f.select…) styled tr-input / tr-select.
    class Component < BaseComponent
      def initialize(label, hint: nil, error: nil, **html)
        @label = label
        @hint = hint
        @error = error
        @html = html
      end
    end
  end
end
