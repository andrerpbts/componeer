require "rails_helper"

RSpec.describe Componeer::TableComponent, type: :component do
  let(:rows) { [ { number: 1, month: "Novembro" }, { number: 2, month: "Outubro" } ] }

  context "with columns, links and groups" do
    before do
      render_inline(described_class.new(rows:, row_href: ->(row) { "/notas/#{row[:number]}" },
        current: ->(row) { row[:number] == 2 }, group_by: ->(row) { row[:month] })) do |table|
        table.column("Número", align: :right) { |row| "Nº #{row[:number]}" }
      end
    end

    it { expect(page).to have_css("th[scope=col]", text: "Número") }
    it { expect(page).to have_css("td[style='text-align: right']", text: "Nº 1") }
    it { expect(page).to have_css("tr.is-clickable[data-componeer--row-link-href-value='/notas/1']") }
    it { expect(page).to have_css("tr.is-current[aria-current=true]", text: "Nº 2") }
    it { expect(page).to have_css("tr.tr-table__group", text: "Outubro") }
  end

  context "without rows" do
    before { render_inline(described_class.new(rows: [], empty: "Nenhuma nota.")) { |table| table.column("Número") { |row| row } } }

    it { expect(page).to have_css("p.tr-empty", text: "Nenhuma nota.") }
  end
end
