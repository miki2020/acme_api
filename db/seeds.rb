# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.create( [
  {"id"=>1, "name"=>"Bronze Box", "price"=>19.99},
  {"id"=>2, "name"=>"Silver Box", "price"=>49.0},
  {"id"=>3, "name"=>"Gold Box", "price"=>99.0}
  ])
Customer.create([{"id"=>1, "name"=>"Customer 1", "address"=>"address 1, city 1", "zip_code"=>"99-999"}])
