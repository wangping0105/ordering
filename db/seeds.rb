# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


shop = Shop.create(sname:'default')
types = %w[套餐]
MealType.delete_all
types.each do |t|
  MealType.create(name: t, store_id: shop.id)
end
OrderUser.create(uname: 'wangping', role: 1, status: 0)
p 'have inited'