require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'unirest'
require 'sinatra'
require 'erb'
require 'sinatra/reloader' if development?
require 'pry'
require_relative './models/film_retriever'
require_relative './models/api_caller'

# Main app class
class MubiMovieRanker < Sinatra::Base
  get '/' do
    @films = films
    erb :main
  end

  def films
    films = FilmRetriever.current_mubi_films
    api_caller = APICaller.new(films)
    films = api_caller.films
    films.sort_by { |film| [film[:rating] ? 1 : 0, film[:rating]] }.reverse
  end
end
