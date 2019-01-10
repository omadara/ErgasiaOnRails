# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'bcrypt'

puts "Deleting existing Categories..."
Category.delete_all
puts "Inserting Categories..."
Category.create!(name: 'Sports')
Category.create!(name: 'News')
Category.create!(name: 'Memes')
Category.create!(name: 'Gossip')
Category.create!(name: 'Style')
Category.create!(name: 'Quotes')

puts "Deleting existing Users..."
User.delete_all
puts "Inserting Users..."
uids = [] # used to make some friends!.....
pass = BCrypt::Password.create('pass')
(0..10).each do |i|
  uids[i] = User.create!(username: "user#{i}", password_digest: pass,
               first_name: "Firstname#{i}", last_name: "Lastname#{i}").id
end

puts "Deleting existing Friends..."
Friend.delete_all
puts "Inserting Friends..."
Friend.create(user1_id: uids[0], user2_id: uids[1], accepted: true)
Friend.create(user1_id: uids[0], user2_id: uids[2], accepted: true)
Friend.create(user1_id: uids[1], user2_id: uids[3], accepted: true)
Friend.create(user1_id: uids[1], user2_id: uids[4], accepted: true)
Friend.create(user1_id: uids[4], user2_id: uids[5], accepted: true)
# user1 is the sender, user2 is the receiver
puts "Inserting pending Friend requests..."
Friend.create(user1_id: uids[0], user2_id: uids[6], accepted: false)
Friend.create(user1_id: uids[0], user2_id: uids[7], accepted: false)
Friend.create(user1_id: uids[1], user2_id: uids[5], accepted: false)
Friend.create(user1_id: uids[1], user2_id: uids[7], accepted: false)
Friend.create(user1_id: uids[4], user2_id: uids[0], accepted: false)
Friend.create(user1_id: uids[5], user2_id: uids[0], accepted: false)
Friend.create(user1_id: uids[8], user2_id: uids[0], accepted: false)
