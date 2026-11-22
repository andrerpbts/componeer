module Componeer
  module Sidebar
    class Component < BaseComponent
      renders_one :brand_logo
      renders_many :entries, types: { link: NavItem::Component, heading: Heading }
      renders_one :footer

      def initialize(brand: nil, brand_href: "/", label: "Navegação principal", **html)
        @brand = brand
        @brand_href = brand_href
        @label = label
        @html = html
      end

      # sidebar.with_item("Agenda", href: agenda_path, icon: "calendar")
      def with_item(...)
        with_entry_link(...)
      end

      # sidebar.with_heading("Negócios") groups the items after it.
      def with_heading(text)
        with_entry_heading(text)
      end
    end
  end
end
