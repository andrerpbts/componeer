module Componeer
  class Configuration
    # Folders searched, in order, for "<name>.svg" before the bundled Tabler outline set.
    attr_accessor :icon_paths

    def initialize
      @icon_paths = []
    end
  end
end
