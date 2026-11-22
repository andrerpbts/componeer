require "rails_helper"

RSpec.describe Componeer::CodeBlockComponent, type: :component do
  context "with Ruby source" do
    before { render_inline(described_class.new("def hello = :world", language: :ruby)) }

    it { expect(page).to have_css("figure.tr-code .tr-code__title", text: "Ruby") }
    it { expect(page).to have_css("pre.tr-code__pre code .k", text: "def") }
    it { expect(page).to have_css("code .ss", text: ":world") }
    it { expect(page).to have_css("button[data-action='componeer--clipboard#copy']", text: "Copiar") }
  end

  context "with markup in the source" do
    before { render_inline(described_class.new("<script>alert(1)</script>", language: :html, title: "x.html")) }

    it { expect(page).to have_no_css("code script") }
    it { expect(page).to have_css(".tr-code__title", text: "x.html") }
  end

  context "with an unknown language and no copy" do
    before { render_inline(described_class.new("texto", language: :nope, copy: false)) }

    it { expect(page).to have_css("code", text: "texto") }
    it { expect(page).to have_no_css("button") }
  end

  context "with the source as a block" do
    before { render_inline(described_class.new(language: :ruby)) { "puts 1" } }

    it { expect(page).to have_css("code .nb, code .k", text: "puts") }
  end
end
