# Serves the documentation app (spec/dummy, with Componeer mounted at /componeer) when the
# repository itself is deployed, e.g. on Render. The gem does not use this file.
require_relative "spec/dummy/config/environment"

run Rails.application
