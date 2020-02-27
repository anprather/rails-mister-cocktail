require 'faker'
require 'open-uri'

puts 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Creating cocktails...'

# parse through api to create database of coctails, then an ingredients list
DOSES = ['a pinch', 'a squeeze' '0.5 parts', '1 part','2 parts', '3 parts', '4 parts']

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredients['drinks'].each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

10.times do
  cocktail = Cocktail.new(
    name: Faker::Hipster.sentence(word_count: 2)
  )
  cocktail.save

  rand(1..5).times do
    dose = Dose.new(
      cocktail: cocktail,
      ingredient: Ingredient.all.sample,
      description: DOSES.sample
    )
    dose.save
  end
end
