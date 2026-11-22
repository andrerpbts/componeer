module Componeer
  # Label + control + hint/error. The block is the control (text_field_tag, f.select…) styled tr-input / tr-select.
  class FieldComponent < Component
    def initialize(label, hint: nil, error: nil, **html)
      @label, @hint, @error, @html = label, hint, error, html
    end

    def call
      message = if @error
        tag.span(@error, class: "tr-hint", style: "color: var(--bad-text)")
      elsif @hint
        tag.span(@hint, class: "tr-hint")
      end

      tag.label safe_join([ @label, content, message ].compact), **html_attributes("tr-field", @html)
    end
  end
end
