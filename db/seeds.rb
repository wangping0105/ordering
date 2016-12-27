# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

types = %w[默认饭馆]
MealType.delete_all
shop = Shop.create(sname:'默认店', status:1)
types.each do |t|
  MealType.create(name: t, store_id: shop.id)
end

User.create(username: 'wangping', role: 1, phone: 15921076830, password: "admin")
p 'have inited'


