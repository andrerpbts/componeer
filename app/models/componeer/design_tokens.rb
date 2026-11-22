module Componeer
  # Trail UI tokens with their usage notes, from config/tokens.json (a copy of the design system's
  # tokens.json). Read by the Theming docs page.
  class DesignTokens
    Token = Data.define(:name, :value, :usage, :family) do
      def color?
        family == "color"
      end

      def css_variable
        "--#{name}"
      end
    end

    FAMILIES = { "color" => "Colours", "spacing" => "Spacing", "radius" => "Radii", "shadow" => "Shadows", "size" => "Sizes" }.freeze

    def self.grouped
      data = JSON.parse(Engine.root.join("config/tokens.json").read)
      FAMILIES.to_h do |family, label|
        tokens = data.fetch(family, {}).fetch("tokens", []).map do |token|
          value = token["value"].is_a?(Hash) ? token["value"].values.first : token["value"]
          Token.new(name: token["name"], value: value.to_s.gsub(/\{([^}]+)\}/, 'var(--\1)'), usage: token["usage"], family:)
        end
        [ label, tokens ]
      end
    end
  end
end
