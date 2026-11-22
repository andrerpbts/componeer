require "rails_helper"

RSpec.describe Componeer::PaginationComponent, type: :component do
  let(:url) { ->(page) { "/notas?page=#{page}" } }

  context "when in the middle of many pages" do
    before { render_inline(described_class.new(page: 7, pages: 24, url:)) }

    it { expect(page).to have_css("nav.tr-pagination a[aria-current=page]", text: "7") }
    it { expect(page).to have_css("a[href='/notas?page=1']", text: "1") }
    it { expect(page).to have_css("a[href='/notas?page=24']", text: "24") }
    it { expect(page).to have_css(".tr-pagination__gap", count: 2, visible: :all) }
    it { expect(page).to have_css("a[rel=prev][href='/notas?page=6']") }
  end

  context "when on the first page" do
    before { render_inline(described_class.new(page: 1, pages: 3, url:)) }

    it { expect(page).to have_css("span[aria-disabled=true][aria-label='Página anterior']") }
    it { expect(page).to have_no_css(".tr-pagination__gap", visible: :all) }
  end

  context "with a single page" do
    before { render_inline(described_class.new(page: 1, pages: 1, url:)) }

    it { expect(page).to have_no_css("nav") }
  end
end
