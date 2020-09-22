# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Like.destroy_all
Doom.destroy_all
DMeter.destroy_all
User.destroy_all


user = User.create!(username: 'admin', email: 'zzz@zzz.zzz', password: '12345678', password_confirmation: '12345678', admin: true, tos_agreement: true)
user.confirm

d_meter = DMeter.create!(user_id: User.first.id, name: 'Default Doom Meter', link: '/',
               doom_lvl_0: 'level 0', doom_lvl_1: 'level 1', doom_lvl_2: 'level 2',
               doom_lvl_3: 'level 3', doom_lvl_4: 'level 4', doom_lvl_5: 'level 5',
               doom_lvl_6: 'level 6', doom_lvl_7: 'level 7', doom_lvl_8: 'level 8',
               doom_lvl_9: 'level 9', doom_lvl_10: 'level 10', doom_lvl_11: 'level 11',
               doom_lvl_12: 'level 12', public: true)


20.times do |i|
  Doom.create(user_id: user.id, d_meter_id: d_meter.id, level: "doom_lvl_#{rand(13)}", text: "hooooochu", active: true)
end

user = User.create!(username: 'aaaaa', email: 'aaa@aaa.aaa', password: '12345678', password_confirmation: '12345678', admin: false, tos_agreement: true)
user.confirm

20.times do |i|
  Doom.create(user_id: user.id, d_meter_id: d_meter.id, level: "doom_lvl_#{rand(13)}", text: "hooooochu", active: true)
end

user = User.create!(username: 'bbbbb', email: 'bbb@bbb.bbb', password: '12345678', password_confirmation: '12345678', admin: false, tos_agreement: true)
user.confirm

20.times do |i|
  Doom.create(user_id: user.id, d_meter_id: d_meter.id, level: "doom_lvl_#{rand(13)}", text: "hooooochu", active: true)
end

user = User.create!(username: 'ccccc', email: 'ccc@ccc.ccc', password: '12345678', password_confirmation: '12345678', admin: false, tos_agreement: true)
user.confirm

20.times do |i|
  Doom.create(user_id: user.id, d_meter_id: d_meter.id, level: "doom_lvl_#{rand(13)}", text: "hooooochu", active: true)
end

user = User.create!(username: 'ddddd', email: 'ddd@ddd.ddd', password: '12345678', password_confirmation: '12345678', admin: false, tos_agreement: true)
user.confirm

20.times do |i|
  Doom.create(user_id: user.id, d_meter_id: d_meter.id, level: "doom_lvl_#{rand(13)}", text: "hooooochu", active: true)
end

user = User.create!(username: 'fffff', email: 'fff@fff.fff', password: '12345678', password_confirmation: '12345678', admin: false, tos_agreement: true)
user.confirm

20.times do |i|
  Doom.create(user_id: user.id, d_meter_id: d_meter.id, level: "doom_lvl_#{rand(13)}", text: "hooooochu", active: true)
end

# user = User.create!(username: 'kkkkk', email: 'kkk@kkk.kkk', password: '12345678', password_confirmation: '12345678', admin: false, tos_agreement: true)
# user.confirm


