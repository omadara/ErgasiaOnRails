# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'bcrypt'

User.delete_all
User.create!(username: 'user', password_digest: BCrypt::Password.create('pass'),
             first_name: 'Firstname', last_name: 'Lastname')

Category.delete_all
Category.create!(name: 'Sports')
Category.create!(name: 'News')
Category.create!(name: 'Memes')
Category.create!(name: 'Gossip')
Category.create!(name: 'Style')
Category.create!(name: 'Quotes')
