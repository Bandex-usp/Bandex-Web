require 'open-uri'

text = open('./central.html').read
text.force_encoding('windows-1252')
p text