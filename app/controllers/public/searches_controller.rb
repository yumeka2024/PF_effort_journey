class Public::SearchesController < ApplicationController

  def search
    @search_results = SearchService.new(params[:query]).perform_search
  end

end
