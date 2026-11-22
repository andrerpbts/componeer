module Componeer
  # Says what is empty in the list's own terms and, when there is one, the way out.
  #   empty_state("Nenhuma nota neste filtro", description: "Mude o período ou limpe a busca.", icon: "file-off") do |e|
  #     e.with_action { button "Limpar filtros" }
  #   end
  class EmptyStateComponent < Component
    SIZES = %i[md sm].freeze

    renders_many :actions

    def initialize(title = nil, description: nil, icon: nil, size: :md, bordered: false, **html)
      @title, @description, @icon, @size, @bordered, @html = title, description, icon, size.to_sym, bordered, html
      raise ArgumentError, "unknown size #{size.inspect}" unless SIZES.include?(@size)
    end

    def call
      tag.div(**html_attributes(classes, @html, role: "status")) do
        safe_join [
          (tag.span(icon_svg(@icon, size: @size == :sm ? 18 : 24), class: "tr-empty-state__icon") if @icon),
          (tag.p(@title, class: "tr-empty-state__title") if @title),
          (tag.p(@description, class: "tr-empty-state__text") if @description),
          (content if content?),
          (tag.div(safe_join(actions), class: "tr-empty-state__actions") if actions?)
        ].compact
      end
    end

    private
      def classes
        class_names("tr-empty-state", "tr-empty-state--sm" => @size == :sm, "tr-empty-state--bordered" => @bordered)
      end
  end
end
