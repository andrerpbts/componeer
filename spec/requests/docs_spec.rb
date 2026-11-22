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

  describe "GET /componeer/missing" do
    before { get "/componeer/missing" }

    it { expect(response).to have_http_status(:not_found) }
  end
end
