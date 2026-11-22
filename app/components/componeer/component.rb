module Componeer
  class Component < ViewComponent::Base
    private
      # Merges caller-supplied HTML attributes into the component's own, appending to "class" and "style".
      def html_attributes(base_class, html, **own)
        html = html.dup
        extra_class, extra_style = html.delete(:class), html.delete(:style)
        style = [ own[:style], extra_style ].compact_blank.join("; ").presence
        own.deep_merge(html).merge(class: class_names(base_class, own[:class], extra_class), style: style)
      end

      def icon_svg(name, size: 16)
        render Componeer::IconComponent.new(name, size: size)
      end
  end
end
