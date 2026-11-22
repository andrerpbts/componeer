module Componeer
  module Badge
    class Component < BaseComponent
      def initialize(label = nil, **html)
        @label = label
        @html = html
      end
    end
  end
end
