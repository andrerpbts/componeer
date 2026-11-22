require "rails_helper"

RSpec.describe Componeer::CardComponent, type: :component do
  context "with title, actions and footer" do
    before do
      render_inline(described_class.new(title: "Quest", subtitle: "Projeto Exemplo")) do |card|
        card.with_action { "Ação" }
        card.with_footer { "Rodapé" }
        "Corpo"
      end
    end

    it { expect(page).to have_css(".tr-card .tr-card__title", text: "Quest") }
    it { expect(page).to have_css(".tr-card__subtitle", text: "Projeto Exemplo") }
    it { expect(page).to have_css(".tr-card__header", text: "Ação") }
    it { expect(page).to have_css(".tr-card__body", text: "Corpo") }
    it { expect(page).to have_css(".tr-card__footer", text: "Rodapé") }
  end

  context "without header content" do
    before { render_inline(described_class.new) { "Só corpo" } }

    it { expect(page).to have_no_css(".tr-card__header") }
  end

  context "when flush" do
    before { render_inline(described_class.new(flush: true)) { "Tabela" } }

    it { expect(page).to have_css(".tr-card.tr-card--flush") }
  end
end
