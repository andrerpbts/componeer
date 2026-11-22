require "rails_helper"

RSpec.describe Componeer::IconGallery do
  describe "browsing" do
    subject(:gallery) { described_class.new }

    it { expect(gallery.letter).to eq("a") }
    it { expect(gallery.names.size).to eq(described_class::PER_PAGE) }
  end

  describe "by letter" do
    subject(:gallery) { described_class.new(letter: "c") }

    it { expect(gallery.names).to all(start_with("c")) }
  end

  describe "searching" do
    subject(:gallery) { described_class.new(query: "Arrow Up") }

    it { expect(gallery.query).to eq("arrow-up") }
    it { expect(gallery.letter).to be_nil }
    it { expect(gallery.matches).to all(include("arrow-up")) }
  end

  describe "searching within a letter" do
    subject(:gallery) { described_class.new(query: "arrow", letter: "c") }

    it { expect(gallery.matches).to all(start_with("c").and(include("arrow"))) }
    it { expect(gallery.letters.fetch("z")).to eq(0) }

    it do
      expect(gallery.params_with(page: 2))
        .to eq(variant: :outline, q: "arrow", letter: "c", page: 2)
    end
  end

  describe "paging" do
    subject(:gallery) { described_class.new(letter: "c", page: 2) }

    it { expect(gallery.names.first).to eq(gallery.matches[described_class::PER_PAGE]) }
    it { expect(described_class.new(letter: "c", page: 999).page).to eq(gallery.pages) }
  end

  describe "filled" do
    it { expect(described_class.new(variant: "filled").variant).to eq(:filled) }
  end
end
