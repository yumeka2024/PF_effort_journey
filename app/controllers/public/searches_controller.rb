class Public::SearchesController < ApplicationController

  def search
    @search_results = SearchService.new(params[:query]).perform_search
    session[:search_results] = @search_results
    redirect_back fallback_location: root_path
  end

end
