# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.create([{name:'central'}, {name:'quimica'}, {name:'fisica'}])

case Rails.env
when 'development'
  (1..3).each do |index|
    n = Random.rand(20)
    (0..(10+n)).each do
      submit = Restaurant.lunch_openning + Random.rand(7200).seconds
      LineStatus.create!(submit_date: submit, status: Random.rand(6), restaurant_id: index)
    end
  end
end