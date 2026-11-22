require "rails_helper"

RSpec.describe Componeer::TabPanelComponent, type: :component do
  context "when not selected" do
    before { render_inline(described_class.new(id: "done")) { "Conteúdo" } }

    it { expect(page).to have_css("div#done[role=tabpanel][aria-labelledby=done-tab][hidden]", visible: :all) }
  end

  context "when selected" do
    before { render_inline(described_class.new(id: "active", selected: true)) { "Conteúdo" } }

    it { expect(page).to have_css("#active[role=tabpanel]", text: "Conteúdo") }
  end
end
