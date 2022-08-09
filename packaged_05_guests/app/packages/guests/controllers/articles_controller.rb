class ArticlesController < ApplicationController
  before_action :set_author

  def index
    @articles = Blog.where(user_id: params[:author_id])
  end

  def show
    @article = Blog.find_by(id: params[:id], user_id: params[:author_id])
  end

  private

  def set_author
    @author = User.find(params[:author_id])
  end
end
