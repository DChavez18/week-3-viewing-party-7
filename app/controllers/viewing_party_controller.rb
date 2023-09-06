class ViewingPartyController < ApplicationController
  before_action :login_check, only: [:new]

  def new
    @movie = Movie.find(params[:movie_id])
    require 'pry'; binding.pry
  end

  private

  def login_check
    if !session[:user_id]
      flash[:error] = "You must be logged in to create a viewing party!"
      redirect_to movie_path(params[:movie_id])
    end
  end
end