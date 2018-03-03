# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Default Admin
User.create(
  email: "homer@simpson.com",
  password: "123456",
  role: "admin" #記得管理員的差別是 role
)
puts "Default admin Homer created!"
