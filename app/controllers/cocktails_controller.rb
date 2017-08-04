require 'open-uri'
require 'json'

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.remote_photo_url = params[:cocktail][:photo_url]

    if @cocktail.save
      flash[:error] = nil
      redirect_to cocktail_path(@cocktail)
    else
      flash[:error] = "Sorry, it was not possible to create your cocktail"
      render :new
    end

  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :photo_cache, :photo_url, :photo_url_cache)
  end
end
