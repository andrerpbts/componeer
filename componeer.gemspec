require_relative "lib/componeer/version"

Gem::Specification.new do |spec|
  spec.name        = "componeer"
  spec.version     = Componeer::VERSION
  spec.authors     = [ "André Rodrigues" ]
  spec.homepage    = "https://github.com/andrerpbts/componeer"
  spec.summary     = "Trail UI components for Rails views, written as nestable helpers."
  spec.description = "Componeer renders the Trail UI design system in Rails with ViewComponent. " \
                     "Every component is a view helper (card, button, page_header, table…) that takes a block, " \
                     "so screens are built by nesting components."
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 3.3"

  # Not released to RubyGems.org yet: install it from git.
  spec.metadata["allowed_push_host"] = "https://localhost.invalid"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  end

  spec.add_dependency "actionpack", ">= 8.0"
  spec.add_dependency "actionview", ">= 8.0"
  spec.add_dependency "railties", ">= 8.0"
  spec.add_dependency "rouge", ">= 4.0"
  spec.add_dependency "view_component", "~> 4.0"
end
