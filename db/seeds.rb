# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP Admin User'
user = User.create! :email => 'danvalencia@gmail.com', :password => 'backh0ff1', :password_confirmation => 'backh0ff1', :admin => true
