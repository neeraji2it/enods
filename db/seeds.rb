# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:email => 'admin@gmail.com', :password => '12345678', :password_confirmation => '12345678', :role => 'admin',:confirmation_token => '',:confirmed_at => Time.now)
User.create(:email => 'rails@gmail.com', :password => '12345678', :password_confirmation => '12345678', :role => 'seller',:confirmation_token => '',:confirmed_at => Time.now)
User.create(:email => 'neeraj@gmail.com', :password => '12345678', :password_confirmation => '12345678', :role => 'buyer',:confirmation_token => '',:confirmed_at => Time.now)
User.create(:email => 'railsdev@gmail.com', :password => '12345678', :password_confirmation => '12345678', :role => 'non-profit',:confirmation_token => '',:confirmed_at => Time.now)

if Category.count == 0
  Category.create(:name => 'Art')
  Category.create(:name => 'Home & Living')
  Category.create(:name => 'Jewelry')
  Category.create(:name => 'Women')
  Category.create(:name => 'Men')
  Category.create(:name => 'Kids')
  Category.create(:name => 'Vintage')
  Category.create(:name => 'Weddings')
  Category.create(:name => 'Craft Supplies')
  Category.create(:name => 'Trending Items')
  Category.create(:name => 'Mothers Day Gifts')
  Category.create(:name => 'Gift Ideas')
  Category.create(:name => 'Mobile Accessories')
end
