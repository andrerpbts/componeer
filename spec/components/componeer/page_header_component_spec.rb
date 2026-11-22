require "rails_helper"

RSpec.describe Componeer::PageHeaderComponent, type: :component do
  before do
    render_inline(described_class.new(title: "Notas", subtitle: "Última sincronização: há 5 minutos")) do |header|
      header.with_action { "Exportar" }
      header.with_filters { "Filtros" }
      header.with_tabs(label: "Tipo de nota") do |tabs|
        tabs.with_tab("Emitidas", href: "/emitidas", count: 1204, selected: true)
        tabs.with_tab("Recebidas", href: "/recebidas", count: 3)
      end
    end
  end

  it { expect(page).to have_css("h1", text: "Notas") }
  it { expect(page).to have_css(".tr-page-header__sub", text: "há 5 minutos") }
  it { expect(page).to have_css(".tr-page-header", text: "Exportar") }
  it { expect(page).to have_css(".tr-filters", text: "Filtros") }
  it { expect(page).to have_css("[role=tablist][aria-label='Tipo de nota'] a.tr-tab[aria-selected=true]", text: "Emitidas") }
  it { expect(page).to have_css(".tr-tab .tr-count", text: "1,204") }
end
