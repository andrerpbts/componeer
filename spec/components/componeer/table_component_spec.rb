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

  context "with collapsible groups" do
    before do
      render_inline(described_class.new(rows:, group_by: ->(row) { row[:month] }, collapsible: true, collapsed: [ "Outubro" ])) do |table|
        table.column("Número") { |row| row[:number] }
      end
    end

    it { expect(page).to have_css("tbody[data-controller='componeer--table-group']", count: 2) }
    it { expect(page).to have_css("tbody:not([data-collapsed]) .tr-table__toggle[aria-expanded=true]", text: "Novembro") }
    it { expect(page).to have_css("tbody[data-collapsed] .tr-table__toggle[aria-expanded=false]", text: "Outubro") }
  end

  context "when a column block returns a number" do
    before { render_inline(described_class.new(rows:)) { |table| table.column("Número") { |row| row[:number] } } }

    it { expect(page).to have_css("td", text: "2") }
  end

  context "without rows" do
    before { render_inline(described_class.new(rows: [], empty: "Nenhuma nota.")) { |table| table.column("Número") { |row| row } } }

    it { expect(page).to have_css("table thead th", text: "Número") }
    it { expect(page).to have_css("tbody tr.tr-table__empty td[colspan='1'] .tr-empty-state__title", text: "Nenhuma nota.") }
  end

  context "without rows and a custom empty block" do
    before do
      render_inline(described_class.new(rows: [])) do |table|
        table.column("Número") { |row| row }
        table.empty { "Nada aqui, limpe os filtros" }
      end
    end

    it { expect(page).to have_css("tr.tr-table__empty td", text: "Nada aqui, limpe os filtros") }
  end
end
