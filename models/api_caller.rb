# Makes API calls - the default is to the IMDb API.
class APICaller

  def initialize(films)
    @key = '47d7375b'
    @films = films
  end

  def films
    add_api_info_to_films
    @films
  end

  def add_api_info_to_films
    @films.each do |film|
      api_info = return_rating_and_plot(film)
      film[:rating] = api_info[:rating]
      film[:plot] = api_info[:plot]
    end
  end

  def return_rating_and_plot(film)
    title = film[:ascii_dashed_title]
    year = film[:year]

    response = Unirest.get "http://www.omdbapi.com/?apikey=#{@key}&t=#{title}&y=#{year}"

    rating = response.body['imdbRating']
    plot = response.body['Plot']
    # (plot == nil || plot == "N/A") ?

    Hash[rating: rating, plot: plot]
  end
end

  # def return_imdb_rating(film)
  #   title = film[:ascii_dashed_title]
  #   year = film[:year]
  #
  #   url = "http://www.omdbapi.com/?apikey=#{IMDB_KEY}&t=#{title}&y=#{year}"
  #   response = Unirest.get url
  #   response.body['imdbRating']
  #   response.body['Plot']
  #
  # end
  #
  # def return_imdb_plot(film)
  #   title = film[:ascii_dashed_title]
  #   year = film[:year]
  #
  #   url = "http://www.omdbapi.com/?apikey=#{IMDB_KEY}&t=#{title}&y=#{year}"
  #   response = Unirest.get url
  #   response.body['Plot']
  # end

# end
