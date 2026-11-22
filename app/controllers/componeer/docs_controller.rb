module Componeer
  class DocsController < ApplicationController
    layout "componeer/docs"

    def show
      @page = DocPage.find(params[:slug]) or raise ActionController::RoutingError, "No doc page #{params[:slug]}"
    end

    # A whole example screen, outside the documentation shell.
    def screen
      raise ActionController::RoutingError, "No screen #{params[:screen]}" unless DocPage.screens.include?(params[:screen])

      @screen = params[:screen]
      render layout: "componeer/screen"
    end
  end
end
