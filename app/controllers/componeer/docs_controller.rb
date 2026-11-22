module Componeer
  class DocsController < ApplicationController
    layout "componeer/docs"

    def show
      @page = DocPage.find(params[:slug]) or raise not_found("No doc page #{params[:slug]}")
    end

    # A whole example screen, outside the documentation shell.
    def screen
      unless DocPage.screens.include?(params[:screen])
        raise not_found("No screen #{params[:screen]}")
      end

      @screen = params[:screen]
      render layout: "componeer/screen"
    end

    private

    def not_found(message)
      ActionController::RoutingError.new(message)
    end
  end
end
