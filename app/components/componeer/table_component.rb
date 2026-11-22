module Componeer
  # Dense data table. Declare columns in the block; each column block receives the row:
  #
  #   table(rows: @notes, row_href: ->(note) { note_path(note) }) do |t|
  #     t.column("Número", align: :right) { |note| note.number }
  #   end
  class TableComponent < Component
    Column = Data.define(:header, :align, :width, :block)

    def initialize(rows:, row_href: nil, current: nil, group_by: nil, empty: "Nada por aqui.", min_width: nil, **html)
      @rows, @row_href, @current, @group_by, @empty, @min_width, @html = rows.to_a, row_href, current, group_by, empty, min_width, html
      @columns = []
    end

    def column(header, align: :left, width: nil, &block)
      @columns << Column.new(header:, align:, width:, block:)
      nil
    end

    def before_render
      content
    end

    def groups
      @group_by ? @rows.group_by(&@group_by) : { nil => @rows }
    end

    def cell(column, row)
      helpers.capture(row, &column.block)
    end

    def row_attributes(row)
      href = @row_href&.call(row)
      current = @current&.call(row)
      { class: class_names("is-clickable" => href, "is-current" => current),
        data: ({ controller: "componeer--row-link", action: "click->componeer--row-link#visit", "componeer--row-link-href-value": href } if href),
        aria: { current: (current ? "true" : nil) } }
    end

    def align_style(column)
      [ ("text-align: #{column.align}" unless column.align == :left), ("width: #{column.width}" if column.width) ].compact.join("; ").presence
    end
  end
end
