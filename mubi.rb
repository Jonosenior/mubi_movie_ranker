require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'unirest'
#
#
page_url = 'https://mubi.com/showing'
page = Nokogiri::HTML(open(page_url))
#
#
# # current_films_buttons = page.css('div#page-region a').select do |a|
# #   a['href'] if a['href'].match('/showing/')
# # end
#
film_title_elements = page.css('#page-region h2')
film_year_elements = page.css('#page-region h3')
titles = film_title_elements.map { |a| a.text }
years = film_year_elements.map { |b| b.text.match(/\d{4}/) }

films = (0..29).to_a.map do |i|
  { title: titles[i],
    year: years[i].to_s
  }
end

# puts films
films.each { |film| film.each { |key, value| puts "#{key}: #{value}\n\n" } }


# film_year_elements.select { |b| b.text
#
# film_title_elements.each { |a| puts a.text }
# film_year_elements.each { |a| puts a.text }

#current_films_titles.each {|a| puts a.text }
#
#
# titles = current_films_buttons.map do |a|
#   a['href'].sub('/showing/', '')
# end
#
# imdb_key = '47d7375b'
#
# titles.each do |title|
#   url = "http://www.omdbapi.com/?apikey=#{imdb_key}&t=#{title}"
#   response = Unirest.get url
#   rating = response.body["imdbRating"]
#   puts "#{title}, #{rating}"
# end
#
# # IMDB api call
#
#
# url = "http://www.omdbapi.com/?apikey=#{imdb_key}&t=the-wave"
# response = Unirest.get url
# # puts response.body["Title"]
# # puts response.body["imdbRating"]
# # puts response.body["Ratings"]["Source"]
