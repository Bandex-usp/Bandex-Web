json.array!(@line_statuses) do |line_status|
  json.extract! line_status, :id, :submit_date, :status, :restaurant_id
  json.url line_status_url(line_status, format: :json)
end
