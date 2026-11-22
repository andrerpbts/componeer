source "https://rubygems.org"

# Specify your gem's dependencies in componeer.gemspec.
gemspec

gem "puma"
gem "propshaft"
gem "importmap-rails"
gem "stimulus-rails"

# Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
gem "rubocop-rails-omakase", require: false
gem "rubocop-rspec", require: false

group :development, :test do
  gem "debug", ">= 1.0.0"
  gem "rspec-rails"
end

group :test do
  gem "capybara"
end
