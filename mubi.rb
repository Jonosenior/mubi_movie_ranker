require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'unirest'
require 'sinatra'
require 'erb'
require 'sinatra/reloader' if development?


get '/' do
  films = current_mubi_films
  films = add_rating(films)
  @films = films.sort_by { |film| [film[:rating] ? 1 : 0, film[:rating]]  }.reverse
  erb :films
end

MUBI_URL = 'https://mubi.com/showing'
IMDB_KEY = '47d7375b'

def current_mubi_films
  page = Nokogiri::HTML(open(MUBI_URL))

  film_title_elements = page.css('#page-region h2')
  film_year_elements = page.css('#page-region h3')
  # film_title_buttons = page.css('#page-region a').select { |a| a['href'] if a['href'].match(/showing/)}

  titles = film_title_elements.map { |a| a.text }
  years = film_year_elements.map { |b| b.text.match(/\d{4}/) }
  # ascii_dashed_titles = film_title_buttons.map { |a|  a['href'].sub('/showing/', '') }

  films = (0..29).to_a.map do |i|
    { title: titles[i],
      year: years[i].to_s # ,
      # ascii_dashed_title: ascii_dashed_titles[i]
    }
  end
end

def return_imdb_rating(film)
  title = film[:ascii_dashed_title]
  year = film[:year]

  url = "http://www.omdbapi.com/?apikey=#{IMDB_KEY}&t=#{title}&y=#{year}"
  response = Unirest.get url
  rating = response.body["imdbRating"]
end

def add_rating(films)
  films.each do |film|
    rating = return_imdb_rating(film)
    film[:rating] = rating
  end
end
