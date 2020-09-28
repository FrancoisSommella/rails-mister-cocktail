# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Ingredient.create(name: 'lemon')

require 'json'
require 'open-uri'
# seed redouane ---
# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# buffer = open(url).read
# result = JSON.parse(buffer)
# # => repos is an `Array` of `Hashes`.

# result['drinks'].each do |drink|
#   puts drink.to_s
#   ingredient = Ingredient.new(name: drink['strIngredient1'])

#   ingredient.save!
# end

# puts 'Seed Done !'
#            ------

puts "Cleaning database..."
Cocktail.destroy_all
puts "Creating cocktails..."
COCKTAILS_URL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=m"
result = JSON.parse(open(COCKTAILS_URL).read)

result["drinks"].each do |data|
  new_cocktail = Cocktail.new(name: data["strDrink"],
    img_url: data["strDrinkThumb"])
  new_cocktail.save!

  i = 1
  until i > 30 do
    ingredient_id = Ingredient.find_by(name: data["strIngredient#{i}"])&.id
    if ingredient_id.present?
      dose = Dose.new(description: data["strMeasure#{i}"],
        cocktail_id: new_cocktail.id,
        ingredient_id: ingredient_id
      )
      dose.save
    end

    i += 1
  end

end
puts "Finished!"
