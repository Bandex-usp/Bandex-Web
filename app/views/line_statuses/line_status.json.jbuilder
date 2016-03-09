(0...@rest_count).each do |index|
  json.set! index do
    json.set! 'line_status', @currentLineStatus[index]
    json.set! 'last_submit', @lastSubmitDate[index]
  end
end
