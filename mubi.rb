require 'rubygems'
require 'nokogiri'
require 'open-uri'

require 'unirest'


page_url = 'https://mubi.com/showing'
page = Nokogiri::HTML(open(page_url))

current_films_buttons = page.css('div#page-region a').select do |a|
  a['href'] if a['href'].match('/showing/')
end

titles = current_films_buttons.map do |a|
  a['href'].sub('/showing/', '')
end



# puts titles.count


# IMDB api call

imdb_key = '47d7375b'

url = "http://www.omdbapi.com/?apikey=#{imdb_key}&t=the-wave"
response = Unirest.get url
puts response.body["Title"]
puts response.body["imdbRating"]
# puts response.body["Ratings"]["Source"]
