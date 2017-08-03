require 'open-uri'
require 'json'

json = open('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list')

hash = JSON.load(json)

hash['drinks'].each do |ingredient|

  Ingredient.create(name: ingredient['strIngredient1'].to_s)
end
