require "rails_helper"

RSpec.describe Componeer::ButtonComponent, type: :component do
  context "with defaults" do
    before { render_inline(described_class.new("Salvar")) }

    it { expect(page).to have_css("button.tr-btn[type=button]", text: "Salvar") }
    it { expect(page).to have_no_css(".tr-btn--primary") }
  end

  context "when primary with an icon" do
    before { render_inline(described_class.new("Sincronizar", variant: :primary, icon: "refresh")) }

    it { expect(page).to have_css("button.tr-btn.tr-btn--primary svg.tr-icon") }
  end

  context "when danger_fill and small" do
    before { render_inline(described_class.new("Remover", variant: :danger_fill, size: :sm)) }

    it { expect(page).to have_css(".tr-btn.tr-btn--danger-fill.tr-btn--sm") }
  end

  context "with href" do
    before { render_inline(described_class.new("Ver", href: "/notas/1", class: "extra")) }

    it { expect(page).to have_css("a.tr-btn.extra[href='/notas/1']", text: "Ver") }
  end

  context "with a block" do
    before { render_inline(described_class.new) { "Conteúdo" } }

    it { expect(page).to have_css("button", text: "Conteúdo") }
  end

  context "with an unknown variant" do
    it { expect { described_class.new("x", variant: :loud) }.to raise_error(ArgumentError) }
  end
end
