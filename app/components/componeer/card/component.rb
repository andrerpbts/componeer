module Componeer
  module Card
    class Component < BaseComponent
      renders_many :actions
      renders_one :footer

      def initialize(title: nil, subtitle: nil, flush: false, **html)
        @title = title
        @subtitle = subtitle
        @flush = flush
        @html = html
      end

      private

      def header?
        @title || @subtitle || actions?
      end
    end
  end
end
