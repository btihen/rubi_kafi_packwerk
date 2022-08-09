class AuthorsController < ApplicationController
  def index
    @authors = User.all
  end

  def show
    @author = User.find(params[:id])
  end
end
