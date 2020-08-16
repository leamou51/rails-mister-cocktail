# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'nokogiri'
require 'faker'


puts "Cleaning database..."

# clearing DB
Cocktail.destroy_all
Dose.destroy_all
Ingredient.destroy_all

puts "Creating fake cocktails..."

url_list = "https://www.diffordsguide.com/g/1127/worlds-top-100-cocktails/1-20"

html_file = open(url_list).read
html_doc = Nokogiri::HTML(html_file)

cocktails_url =[]
html_doc.search('.long-form p a').each do |element|
  cocktails_url << element.attribute('href').value
end

cocktails_url.delete_at(2)

# puts "COCKTAIL URL"
# puts cocktails_url

cocktails_url.each do |url|
  html_file = open("https://www.diffordsguide.com/#{url}").read
  html_doc = Nokogiri::HTML(html_file)


  cocktail_name = html_doc.search('h1').text.strip.gsub("Cocktail Hall of Fame","")
  cocktail_picture =  "https://source.unsplash.com/random/?cocktail"
  cocktail = Cocktail.new(name: cocktail_name, picture: cocktail_picture)

  # puts "COCKTAIL NAME"
  # puts cocktail.name

  ingredients_and_doses = []
  html_doc.search('.td-align-top').each do |element|
    ingredients_and_doses << element.text.strip
  end

  ingredients = []
  doses = []
  ingredients_and_doses.each_with_index do |element,index|
    if index % 2 == 0
      doses << element
    else
      ingredient = Ingredient.new(name: element)
      ingredient.save
      ingredients << ingredient
    end
  end

  # puts "COCKTAIL INGREDIENTS"
  # puts ingredients

  # puts "COCKTAIL DOSES"
  # puts doses

  doses.each_with_index do |element, index|
    dose = Dose.new(description: element, cocktail: cocktail, ingredient: ingredients[index])
    dose.save
  end

  cocktail.save

end

puts "Finished!"
