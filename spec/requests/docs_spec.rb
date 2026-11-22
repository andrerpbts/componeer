require "rails_helper"

RSpec.describe "Docs" do
  describe "GET /componeer" do
    before { get "/componeer" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to include("Getting started") }
  end

  Componeer::DocPage.all.each do |doc|
    describe "GET /componeer/#{doc.slug}" do
      before { get "/componeer/#{doc.slug}" }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to include(ERB::Util.html_escape(doc.title)) }
    end
  end

  Componeer::DocPage.screens.each do |screen|
    describe "GET /componeer/screens/#{screen}" do
      before { get "/componeer/screens/#{screen}" }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to include("tr-shell") }
    end
  end

  describe "GET /componeer/screens/missing" do
    before { get "/componeer/screens/missing" }

    it { expect(response).to have_http_status(:not_found) }
  end

  describe "GET /componeer/icon" do
    before { get "/componeer/icon" }

    it { expect(response.body.scan('class="doc-icon"').size).to eq(Componeer::IconGallery.new.names.size) }
  end

  describe "GET /componeer/icon?q=arrow&letter=c" do
    before { get "/componeer/icon", params: { q: "arrow", letter: "c" } }

    it { expect(response.body).to include("letter=a&amp;q=arrow&amp;variant=outline") }
    it { expect(response.body).to include('aria-disabled="true" title="Nenhum ícone">Z<') }
  end

  describe "GET /componeer/icon?q=calendar&variant=filled" do
    before { get "/componeer/icon", params: { q: "calendar", variant: "filled" } }

    it { expect(response.body).to include('data-code="icon &quot;calendar&quot;, variant: :filled"') }
  end

  describe "GET /componeer/missing" do
    before { get "/componeer/missing" }

    it { expect(response).to have_http_status(:not_found) }
  end
end
