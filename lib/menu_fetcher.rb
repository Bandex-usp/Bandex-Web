require 'net/http'

module MenuFetcher
  def self.tokenify number
    tokenbuf = []
    charmap = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ*$"
    remainder = number.floor
    while (remainder > 0) do
      tokenbuf << charmap[remainder & 0x3F]
      remainder = (remainder / 64).floor
    end
    tokenbuf.join("")
  end

  def self.get_menu_body rest_id, script_id
    "callCount=1\nwindowName=\nnextReverseAjaxIndex=0\nc0-scriptName=CardapioControleDWR\nc0-methodName=obterCardapioRestUSP\nc0-id=0\nc0-param0=string:#{rest_id}\nbatchId=2\ninstanceId=0\npage=%2Frucard%2FJsp%2FcardapioSAS.jsp%3Fcodrtn%3D6\nscriptSessionId=#{script_id}"
  end

  def self.get_session_id
    session_url = "https://uspdigital.usp.br/rucard/dwr/call/plaincall/__System.generateId.dwr"
    session_body = "callCount=1\nc0-scriptName=__System\nc0-methodName=generateId\nc0-id=0\nbatchId=0\ninstanceId=0\npage=%2Frucard%2FJsp%2FcardapioSAS.jsp%3Fcodrtn%3D6\nscriptSessionId=\nwindowName="

    url = URI.parse(session_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl=true
    request = Net::HTTP::Post.new url
    request.body =  session_body
    response = http.request request

    response.body[/","([^",]*)"\);/, 1]
  end

  def self.get_menu
    menu_url = "https://uspdigital.usp.br/rucard/dwr/call/plaincall/CardapioControleDWR.obterCardapioRestUSP.dwr"

    rest = {
      6 => 'central',
      8 => 'fisica',
      9 => 'quimica'
    }

    session_id = get_session_id
    time = Time.now
    page_id = tokenify(time.sec*1000 + time.usec/1000) + "-" + tokenify(Random.rand() * 1E16);
    script_id = session_id + '/' + page_id

    url = URI.parse(menu_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl=true
    request = Net::HTTP::Post.new url

    rest.each do |key, name|
      restaurant = Restaurant.find_by(name:name)

      request.body =  get_menu_body key, script_id
      response = http.request request

      raw = response.body[/(\[.*\])\);/, 1]
      raw.gsub!('null', 'nil')
      menu_array = eval(raw)

      menu_array.each do |entry|
        entry_date = Date.parse(entry[:dtarfi])
        menu_entry = MenuEntry.find_by(restaurant:restaurant, entry_date:entry_date, period:((entry[:tiprfi] == 'A') ? 0 : 1))
        if menu_entry.nil?
          menu_entry = restaurant.menu_entries.new(entry_date:entry_date, period:((entry[:tiprfi] == 'A') ? 0 : 1))
        end

        menu_array = entry[:cdpdia].split('<br>')
        next if menu_array.size < 7

        if menu_array.size > 7
          if menu_array.size > 8
            menu_array[0] = menu_array[0] + '/' + menu_array[1]
            menu_array.delete_at(1)
          end
          menu_array[4] = menu_array[4] + '/' + menu_array[5]
          menu_array.delete_at(5)
        end

        menu_entry.update(
          main:     menu_array[0],
          meat:     menu_array[1],
          optional: menu_array[2],
          second:   menu_array[3],
          salad:    menu_array[4],
          desert:   menu_array[5],
          raw:      entry[:cdpdia].gsub('<br>', "\n").chomp
        )
      end
    end
  end
end
