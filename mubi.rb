require 'rubygems'
require 'nokogiri'
require 'open-uri'


page_url = 'https://mubi.com/showing'
page = Nokogiri::HTML(open(page_url))

current_films = page.css('div#page-region a').select do |a|
  a['href'] if a['href'].match('/showing/')
end

puts current_films.count
