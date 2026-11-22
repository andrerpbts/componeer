require "rails_helper"

RSpec.describe Componeer::Registry do
  subject(:registry) { described_class.new }

  describe "#register" do
    context "with a free name" do
      before { registry.register(:demo_box, "Componeer::Card::Component") }

      it { expect(registry.fetch(:demo_box)).to eq(Componeer::Card::Component) }
      it { expect(Componeer::Helpers.method_defined?(:demo_box)).to be(true) }
    end

    context "with an Action View helper name" do
      it do
        expect { registry.register(:select, "Componeer::Card::Component") }
          .to raise_error(described_class::NameTaken)
      end
    end
  end

  describe "built-in helpers" do
    it do
      expect(Componeer.registry.names)
        .to include(:card, :button, :page_header, :table, :multi_select)
    end
  end
end
