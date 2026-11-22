module Componeer
  # Every component keeps its markup in component.html.erb next to component.rb;
  # the Ruby class holds data and logic only.
  class BaseComponent < ViewComponent::Base
    strip_trailing_whitespace

    private

    # Merges caller-supplied HTML attributes into the component's own,
    # appending to "class" and "style" instead of replacing them.
    def html_attributes(base_class, html, **own)
      html = html.dup
      extra_class = html.delete(:class)
      extra_style = html.delete(:style)

      own.deep_merge(html).merge(
        class: class_names(base_class, own[:class], extra_class),
        style: [ own[:style], extra_style ].compact_blank.join("; ").presence
      )
    end

    def icon_svg(name, size: 16)
      render Componeer::Icon::Component.new(name, size: size)
    end

    # Returns value as a symbol, or raises when it is not one of allowed.
    def option!(name, value, allowed)
      value = value.to_sym
      return value if allowed.include?(value)

      raise ArgumentError, "unknown #{name} #{value.inspect}, expected one of #{allowed.inspect}"
    end
  end
end
