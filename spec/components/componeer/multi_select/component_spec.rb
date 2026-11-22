require "rails_helper"

RSpec.describe Componeer::MultiSelect::Component, type: :component do
  let(:options) do
    [
      { value: "a", label: "Alfa", sub: "2 itens" },
      { value: "b", label: "Beta", color: "#0d9488" },
      "c"
    ]
  end
  let(:attributes) do
    {
      name: :projects, label: "Projetos", options:,
      all_label: "Todos", none_label: "Nenhum", many_label: "%{count} projetos"
    }
  end

  context "with nothing passed as selected" do
    before { render_inline(described_class.new(**attributes)) }

    it { expect(page).to have_css(".tr-trigger__text", text: "Todos") }
    it { expect(page).to have_css("input[name='projects[]'][value=a][checked]", visible: :all) }
    it { expect(page).to have_css(".tr-menu__all input[checked]", visible: :all) }
    it { expect(page).to have_css(".tr-menu__sub", text: "2 itens", visible: :all) }
    it { expect(page).to have_no_css(".tr-menu__search", visible: :all) }
  end

  context "with one selected" do
    before { render_inline(described_class.new(**attributes, selected: [ "b" ])) }

    it { expect(page).to have_css(".tr-trigger__text", text: "Beta") }
  end

  context "with two selected" do
    before { render_inline(described_class.new(**attributes, selected: %w[a b])) }

    it { expect(page).to have_css(".tr-trigger__text", text: "2 projetos") }
  end

  context "with none selected" do
    before { render_inline(described_class.new(**attributes, selected: [])) }

    it { expect(page).to have_css(".tr-trigger__text", text: "Nenhum") }
  end

  context "when searchable" do
    before { render_inline(described_class.new(**attributes, searchable: true)) }

    it { expect(page).to have_css(".tr-menu__search input[type=search]", visible: :all) }
  end
end
