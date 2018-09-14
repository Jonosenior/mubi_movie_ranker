require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'unirest'
require 'sinatra'
require 'erb'
require 'sinatra/reloader' if development?
require 'pry'
require_relative './models/film_retriever'

# Main app class
class MubiMovieRanker < Sinatra::Base
  get '/' do
    films = FilmRetriever.current_mubi_films
    films = add_rating(films)
    @films = films.sort_by { |film| [film[:rating] ? 1 : 0, film[:rating]]  }.reverse
    erb :main
  end

  IMDB_KEY = '47d7375b'

  def return_imdb_rating(film)
    title = film[:ascii_dashed_title]
    year = film[:year]

    url = "http://www.omdbapi.com/?apikey=#{IMDB_KEY}&t=#{title}&y=#{year}"
    response = Unirest.get url
    response.body['imdbRating']
  end

  def return_imdb_plot(film)
    title = film[:ascii_dashed_title]
    year = film[:year]

    url = "http://www.omdbapi.com/?apikey=#{IMDB_KEY}&t=#{title}&y=#{year}"
    response = Unirest.get url
    response.body['Plot']
  end

  def add_rating(films)
    films.each do |film|
      rating = return_imdb_rating(film)
      plot = return_imdb_plot(film)
      film[:rating] = rating
      film[:plot] = plot
    end
  end
end
