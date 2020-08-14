# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'faker'

puts "Cleaning database..."

# clearing DB
Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

puts "Creating fake cocktails..."

# adding ingredients to DB
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredients["drinks"].each do |ingredient|
  ingredient_db = Ingredient.new(name: ingredient["strIngredient1"])
  ingredient_db.save
end

# creating fake cocktail and adding them to DB
10.times do
  cocktail = Cocktail.new(name: "#{Faker::Space.planet} cocktail" )
  # creating fake doses and adding them to DB
  numb_ingredients = rand(3) + 2
  numb_ingredients.times do
    dose= Dose.new(description: "#{rand(5) + 2}cl", cocktail: cocktail, ingredient: Ingredient.all.to_a.sample)
    dose.save
  end
  cocktail.save
end

puts "Finished!"
