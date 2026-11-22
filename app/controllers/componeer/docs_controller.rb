module Componeer
  class DocsController < ApplicationController
    layout "componeer/docs"

    def show
      @page = DocPage.find(params[:page]) or raise ActionController::RoutingError, "No doc page #{params[:page]}"
    end
  end
end
