module Componeer
  module Icons
    TABLER_PATH = File.expand_path("../../vendor/tabler/outline", __dir__)
    NAME = /\A[a-z0-9-]+\z/

    class Missing < ArgumentError; end

    class << self
      def svg_body(name)
        name = name.to_s.tr("_", "-")
        raise Missing, "invalid icon name #{name.inspect}" unless name.match?(NAME)

        cache.fetch(name) { cache[name] = read(name) }
      end

      def exist?(name)
        !find(name.to_s.tr("_", "-")).nil?
      end

      def reset!
        @cache = {}
      end

      private
        def cache
          @cache ||= {}
        end

        def read(name)
          path = find(name) or raise Missing, "no icon named #{name.inspect}"
          File.read(path)[%r{<svg[^>]*>(.*)</svg>}m, 1]
            .gsub(%r{<path stroke="none" d="M0 0h24v24H0z" fill="none"\s*/>}, "")
            .strip
        end

        def find(name)
          (Componeer.config.icon_paths.map(&:to_s) + [ TABLER_PATH ])
            .map { |dir| File.join(dir, "#{name}.svg") }
            .find { |path| File.file?(path) }
        end
    end
  end
end
