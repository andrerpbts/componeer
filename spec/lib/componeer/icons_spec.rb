require "rails_helper"

RSpec.describe Componeer::Icons do
  describe ".svg_body" do
    it { expect(described_class.svg_body("search")).to include('<path d="M21 21l-6 -6"') }
    it { expect(described_class.svg_body("search")).not_to include("M0 0h24v24H0z") }
    it { expect(described_class.svg_body(:alert_triangle)).to include("<path") }
    it { expect { described_class.svg_body("nope-not-an-icon") }.to raise_error(described_class::Missing) }
    it { expect { described_class.svg_body("../secrets") }.to raise_error(described_class::Missing) }
    it { expect(described_class.svg_body("star", variant: :filled)).to include("<path") }
    it { expect { described_class.svg_body("search", variant: :bold) }.to raise_error(described_class::Missing) }
  end

  describe ".names" do
    it { expect(described_class.names.size).to eq(4879) }
    it { expect(described_class.names(variant: :filled).size).to eq(785) }
  end

  describe "custom icon paths" do
    let(:dir) { Pathname(Dir.mktmpdir) }

    before do
      dir.join("logo.svg").write('<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="4"/></svg>')
      Componeer.config.icon_paths << dir
      described_class.reset!
    end

    after do
      Componeer.config.icon_paths.delete(dir)
      described_class.reset!
    end

    it { expect(described_class.svg_body("logo")).to include("<circle") }
  end
end
