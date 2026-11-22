module Componeer
  module Table
    # Dense data table. Declare columns in the block; each column block receives the row:
    #
    #   table(rows: @notes, row_href: ->(note) { note_path(note) }) do |t|
    #     t.column("Número", align: :right) { |note| note.number }
    #     t.empty { empty_state "Nenhuma nota", icon: "file-off" }
    #   end
    class Component < BaseComponent
      Column = Data.define(:header, :align, :width, :block)

      def initialize(rows:, row_href: nil, current: nil, group_by: nil, collapsible: false,
        collapsed: [], empty: "Nada por aqui.", min_width: nil, **html)
        @rows = rows.to_a
        @row_href = row_href
        @current = current
        @group_by = group_by
        @collapsible = collapsible && group_by.present?
        @collapsed = Array(collapsed)
        @empty = empty
        @min_width = min_width
        @html = html
        @columns = []
      end

      def column(header, align: :left, width: nil, &block)
        @columns << Column.new(header:, align:, width:, block:)
        nil
      end

      # What shows when there are no rows, usually an empty_state with an icon and an action.
      def empty(&block)
        @empty_block = block
        nil
      end

      # Runs the block first so the columns exist before the template renders.
      def before_render
        content
      end

      private

      def groups
        return {} if @rows.empty?

        @group_by ? @rows.group_by(&@group_by) : { nil => @rows }
      end

      def empty_content
        return helpers.capture(&@empty_block) if @empty_block

        render EmptyState::Component.new(@empty, size: :sm)
      end

      def collapsed?(label)
        @collapsible && @collapsed.include?(label)
      end

      def group_attributes(label)
        return {} unless @collapsible && label

        { data: { controller: "componeer--table-group", collapsed: ("" if collapsed?(label)) } }
      end

      # A column block may write ERB or just return a value (a String, a number…); both render.
      def cell(column, row)
        result = nil
        written = helpers.capture { result = column.block.call(row); nil }
        written.presence || result.to_s
      end

      def row_attributes(row)
        href = @row_href&.call(row)
        current = @current&.call(row)

        {
          class: class_names("is-clickable" => href, "is-current" => current),
          data: (row_link_data(href) if href),
          aria: { current: ("true" if current) }
        }
      end

      def row_link_data(href)
        {
          controller: "componeer--row-link",
          action: "click->componeer--row-link#visit",
          "componeer--row-link-href-value": href
        }
      end

      def cell_style(column)
        styles = []
        styles << "text-align: #{column.align}" unless column.align == :left
        styles << "width: #{column.width}" if column.width
        styles.join("; ").presence
      end
    end
  end
end
