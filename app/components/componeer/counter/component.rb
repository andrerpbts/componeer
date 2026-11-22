module Componeer
  module Counter
    class Component < BaseComponent
      def initialize(value, **html)
        @value = value
        @html = html
      end
    end
  end
end
