require "rails_helper"

RSpec.describe Componeer::DesignTokens do
  subject(:grouped) { described_class.grouped }

  let(:accent) { grouped["Colours"].find { |token| token.name == "accent" } }
  let(:toast) { grouped["Colours"].find { |token| token.name == "toast" } }

  it { expect(grouped.keys).to eq(%w[Colours Spacing Radii Shadows Sizes]) }
  it { expect(accent.value).to eq("#0b5c8a") }
  it { expect(accent.css_variable).to eq("--accent") }
  it { expect(toast.value).to eq("var(--ink)") }

  it do
    tokens_css = Componeer::Engine.root.join("app/assets/stylesheets/componeer/tokens.css").read
    expect(grouped["Colours"].map(&:css_variable))
      .to all(satisfy { |variable| tokens_css.include?("#{variable}:") })
  end
end
