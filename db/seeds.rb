# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Ingredient.create(name: 'lemon')
# Ingredient.create(name: 'ice')
# Ingredient.create(name: 'mint leaves')
# Ingredient.create(name: 'Wodka')
# Cocktail.create(name: 'Mojito')
# Cocktail.create(name: 'Cuba libre')
# Cocktail.create(name: 'Chat botte')
require 'json'
require 'open-uri'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
buffer = open(url).read
result = JSON.parse(buffer)
# => repos is an `Array` of `Hashes`.

result['drinks'].each do |drink|
  puts drink.to_s
  ingredient = Ingredient.new(name: drink['strIngredient1'])

  ingredient.save!
end

puts 'Seed Done !'
