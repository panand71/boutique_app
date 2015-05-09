# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Owner.create!(name:  "Premila Anand",
             email: "panand71@gmail.com",
             password:              "koko2010",
             password_confirmation: "koko2010",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)


# 99.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@gmail.org"
#   password = "password"
#   Owner.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password,
#                activated: true,
#                activated_at: Time.zone.now)
# end