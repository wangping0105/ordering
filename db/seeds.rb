# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

types = %w[默认店]
MealType.delete_all
types.each do |t|
  MealType.create(name: t, store_id: shop.id)
end
Shop.create(sname:'默认饭馆', status:1)

OrderUser.create(uname: 'admin', role: 1, status: 0)
p 'have inited'


