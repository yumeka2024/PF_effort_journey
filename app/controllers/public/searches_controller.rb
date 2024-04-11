class Public::SearchesController < ApplicationController

  def search
    @search_results = SearchService.new(params[:query]).perform_search
    @user_results = @search_results[:users]
    @post_results = @search_results[:posts]
    # @label_results = @search_results[:labels]
    redirect_back fallback_location: root_path
  end

end
