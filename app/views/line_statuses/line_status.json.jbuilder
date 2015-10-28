(0..2).each do |index|
  json.set! index do
    json.set! 'line_status', @currentLineStatus[index]
    json.set! 'last_submit', @lastSubmitDate[index]
    json.set! 'last_status', @last_line_status[index]
  end
end