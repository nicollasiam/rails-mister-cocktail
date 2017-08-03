require 'open-uri'
require 'json'

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all

    @pictures = []

    @cocktails.each do |cocktail|
      url = open("http://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{cocktail.name.downcase}")
      json = JSON.load(url)

      if json['drinks']
        picture = json['drinks'][0]['strDrinkThumb']
      else
        picture = 'https://lorempixel.com/500/500'
      end

      @pictures << { name: cocktail.name, picture: picture }
    end
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
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end

  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
