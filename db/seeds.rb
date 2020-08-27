# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
recipes = []
%w[
    日持ちするもやしナムル
    いろんなレシピに！冷凍しておけるカレー
    お好み焼き大量！
].each do |recipe_title|
    recipes << Recipe.create!(
        title: recipe_title,
        price: rand(400..600),
        cooking_time: rand(10..30),
        description: "#{recipe_title}の作り方",
        storage_method: "冷蔵庫",
    )
end