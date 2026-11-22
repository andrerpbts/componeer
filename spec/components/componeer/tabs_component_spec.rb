require "rails_helper"

RSpec.describe Componeer::TabsComponent, type: :component do
  context "with panels" do
    before do
      render_inline(described_class.new(label: "Situação")) do |tabs|
        tabs.with_tab("Ativas", panel: "active", selected: true)
        tabs.with_tab("Concluídas", panel: "done")
      end
    end

    it { expect(page).to have_css(".tr-tabs-row[data-controller='componeer--tabs']") }
    it { expect(page).to have_css("button#active-tab[role=tab][aria-controls=active][aria-selected=true][tabindex='0']") }
    it { expect(page).to have_css("button[aria-controls=done][aria-selected=false][tabindex='-1']") }
  end

  context "with links" do
    before { render_inline(described_class.new(label: "Situação")) { |tabs| tabs.with_tab("Ativas", href: "/ativas") } }

    it { expect(page).to have_css("a.tr-tab[href='/ativas']") }
  end
end
