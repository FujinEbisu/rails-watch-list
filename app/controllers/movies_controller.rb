class MoviesController < ApplicationController
  before_action :set_movie, only: [:show]

  def index
    @movies = Movie.all
  end

  def show
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :details, :completed)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
