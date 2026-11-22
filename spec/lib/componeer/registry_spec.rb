require "rails_helper"

RSpec.describe Componeer::Registry do
  subject(:registry) { described_class.new }

  describe "#register" do
    context "with a free name" do
      before { registry.register(:demo_box, "Componeer::CardComponent") }

      it { expect(registry.fetch(:demo_box)).to eq(Componeer::CardComponent) }
      it { expect(Componeer::Helpers.method_defined?(:demo_box)).to be(true) }
    end

    context "with an Action View helper name" do
      it { expect { registry.register(:select, "Componeer::CardComponent") }.to raise_error(described_class::NameTaken) }
    end
  end

  describe "built-in helpers" do
    it { expect(Componeer.registry.names).to include(:card, :button, :page_header, :table, :multi_select) }
  end
end
