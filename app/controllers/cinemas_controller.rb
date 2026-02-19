class CinemasController < ApplicationController
  def index
    @cinemas = Cinema.all.order(:name)
  end

  def show
    @cinema = Cinema.find(params[:id])
  end
end
