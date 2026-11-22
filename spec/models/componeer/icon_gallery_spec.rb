require "rails_helper"

RSpec.describe Componeer::IconGallery do
  describe "by letter" do
    subject(:gallery) { described_class.new(letter: "c") }

    it { expect(gallery.letter).to eq("c") }
    it { expect(gallery.names).to all(start_with("c")) }
    it { expect(gallery.letters.keys.first).to eq("a") }
  end

  describe "with an unknown letter" do
    it { expect(described_class.new(letter: "zz").letter).to eq("a") }
  end

  describe "searching" do
    subject(:gallery) { described_class.new(query: "Arrow Up") }

    it { expect(gallery.query).to eq("arrow-up") }
    it { expect(gallery.names).to all(include("arrow-up")) }
    it { expect(gallery.names.size).to be <= described_class::PER_PAGE }
  end

  describe "paging" do
    subject(:gallery) { described_class.new(letter: "c", page: 2) }

    it { expect(gallery.pages).to eq((gallery.matches.size / described_class::PER_PAGE.to_f).ceil) }
    it { expect(gallery.names.first).to eq(gallery.matches[described_class::PER_PAGE]) }
    it { expect(described_class.new(letter: "c", page: 999).page).to eq(gallery.pages) }
  end

  describe "filled" do
    it { expect(described_class.new(variant: "filled").variant).to eq(:filled) }
  end
end
