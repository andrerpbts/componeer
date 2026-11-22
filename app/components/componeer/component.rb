module Componeer
  class Component < ViewComponent::Base
    private
      # Merges caller-supplied HTML attributes into the component's own, appending to "class".
      def html_attributes(base_class, html, **own)
        html = html.dup
        extra_class = html.delete(:class)
        own.deep_merge(html).merge(class: class_names(base_class, own[:class], extra_class))
      end

      def icon_svg(name, size: 16)
        render Componeer::IconComponent.new(name, size: size)
      end
  end
end
