require 'rubygems'
require 'nokogiri'
require 'open-uri'

def getMenu(restaurante)
	url = "http://www.usp.br/coseas/cardapio#{restaurante}.html"
	# url = './central.html'
	body = open(url).read
	body = body.force_encoding('windows-1252')
	doc = Nokogiri::HTML(body)

	menu = Hash.new

	menu_entries = Array.new

	menu[:date] = getDate(doc)

	doc.xpath("//td").each do |e|
		entry = Array.new
		parse_html(e, entry)
		if restaurante == 'quimica'
			entry.delete_at(-2)
		end
		entry.each {|str| str.gsub!(/\/refresco|Opcional /, '')}
		if entry.count > 8
			entry[3] = entry[3] + '/' + entry[4]
			entry.delete_at(4)
		end
		menu_entries << entry if entry.count == 8
	end

	days = ["SEGUNDA", "TERÇA", "QUARTA", "QUINTA", "SEXTA", "SÁBADO", "DOMINGO"]

	menu_entries.select! do |entries|
		days.any? {|day| entries[0].include? day}
	end

	menu[:entries] = menu_entries

  return menu
end

def getDate(doc)
	doc.xpath("//pre").each do |pre|
		/(\d\d)\/(\d{2})\/(\d{2,4})/.match(pre.text) do |match|
			year = match[3]
			year = "20" + year if year.length < 4

			date = Time.new(year, match[2], match[1])

			wdays = ((date.wday + 6) % 7)

			date = date - (60*60*24*wdays)

			return date
		end
	end
end

def parse_html(elem, entry)
	elem.children.each do |e| 
		if e.name == 'pre'
			parse_pre(e, entry)
		elsif e.name == 'p' || e.name == 'font' || e.name == 'span'
			parse_notpre(e, entry)
		else
			parse_html(e, entry)
		end
	end
end

def parse_pre(elem, entry)
	elem.children.each do |elem|
		if elem.name == 'p'|| elem.name == 'span'
			parse_notpre(elem, entry)
			elem.content = ''
		end
	end
	elem.css('br').each{ |br| br.replace "\n" }
	text = elem.text
	text.split("\n").each do |e|
		clean(e)
		if e != nil && e != ""
			entry << e
		end
	end
end

def parse_notpre(elem, entry)
	elem.css('br').each{ |br| br.replace ";" }
	text = elem.text
	text.gsub!(/\n/, "")
	text.split(";").each do |e|
		clean(e)
		if e != nil && e != ""
			entry << e
		end
	end
end

def clean(string)
	string.gsub!(/[^[:alpha:]\s\-\/]/, '')
	string.squeeze!(" ")
	string.strip!
end

# p getMenu(nil)

