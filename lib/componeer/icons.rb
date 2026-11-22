module Componeer
  module Icons
    TABLER_PATH = File.expand_path("../../vendor/tabler", __dir__)
    VARIANTS = %i[outline filled].freeze
    NAME = /\A[a-z0-9-]+\z/

    class Missing < ArgumentError; end

    class << self
      def svg_body(name, variant: :outline)
        name, variant = normalize(name), variant.to_sym
        raise Missing, "unknown icon variant #{variant.inspect}" unless VARIANTS.include?(variant)

        cache.fetch([ variant, name ]) { cache[[ variant, name ]] = read(name, variant) }
      end

      def exist?(name, variant: :outline)
        !find(normalize(name), variant.to_sym).nil?
      rescue Missing
        false
      end

      # Names of the bundled Tabler icons, sorted.
      def names(variant: :outline)
        @names ||= {}
        @names[variant.to_sym] ||= Dir[File.join(TABLER_PATH, variant.to_s, "*.svg")]
          .map { |path| File.basename(path, ".svg") }.sort
      end

      def reset!
        @cache = {}
      end

      private
      def cache
        @cache ||= {}
      end

      def normalize(name)
        name.to_s.tr("_", "-").tap do |normalized|
          raise Missing, "invalid icon name #{name.inspect}" unless normalized.match?(NAME)
        end
      end

      def read(name, variant)
        path = find(name, variant) or raise Missing, "no #{variant} icon named #{name.inspect}"
        File.read(path)[%r{<svg[^>]*>(.*)</svg>}m, 1]
          .gsub(%r{<path stroke="none" d="M0 0h24v24H0z" fill="none"\s*/>}, "")
          .strip
      end

      def find(name, variant)
        (Componeer.config.icon_paths.map(&:to_s) + [ File.join(TABLER_PATH, variant.to_s) ])
          .map { |dir| File.join(dir, "#{name}.svg") }
          .find { |path| File.file?(path) }
      end
    end
  end
end
