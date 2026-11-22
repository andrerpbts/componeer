module Componeer
  module Drawer
    class Section < BaseComponent
      def initialize(title = nil, **html)
        @title = title
        @html = html
      end
    end
  end
end
