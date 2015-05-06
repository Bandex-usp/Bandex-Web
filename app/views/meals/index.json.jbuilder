json.array!(@meals) do |meal|
  json.extract! meal, :id, :main_course, :meat, :second_course, :salad, :optional, :desert
  json.url meal_url(meal, format: :json)
end
