require 'faker'
require 'open-uri'

puts 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Creating cocktails...'

# parse through api to create database of coctails, then an ingredients list
DOSES = ['a pinch', 'a squeeze', '0.5 parts', '1 part','2 parts', '3 parts', '4 parts']

# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# ingredients_serialized = open(url).read
# ingredients = JSON.parse(ingredients_serialized)

# ingredients['drinks'].each do |ingredient|
#   Ingredient.create(name: ingredient['strIngredient1'])
# end

# 10.times do
#   cocktail = Cocktail.new(
#     name: Faker::Hipster.sentence(word_count: 2)
#   )
#   cocktail.save

#   rand(1..5).times do
#     dose = Dose.new(
#       cocktail: cocktail,
#       ingredient: Ingredient.all.sample,
#       description: DOSES.sample
#     )
#     dose.save
#   end
# end

("a".."z").each do |letter|
url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}"
puts "getting #{letter}"
response = open(url).read
cocktail_repo = JSON.parse(response)
cocktails = cocktail_repo["drinks"]
next if cocktails.nil?
cocktails.each do |cocktail|
  new_cocktail = Cocktail.create(name: cocktail['strDrink'])
  i = 1
  loop do
    ingredient_name = cocktail["strIngredient#{i}"]
    ingredient_description = cocktail["strMeasure#{i}"]
    break if ingredient_name == nil
    new_ingredient = Ingredient.find_or_create_by(name: ingredient_name)
    Dose.create(cocktail: new_cocktail, ingredient: new_ingredient, description: ingredient_description)
    i += 1
    end
  end
end
