# Makes API calls - the default is to the IMDb API.
class APICaller
  def initialize(args)
    @key = args.fetch(:key, '47d7375b')
    @films = args.fetch(:films)
    @url = args.fetch(:url, "http://www.omdbapi.com/?apikey=#{@key}&t=#{title}&y=#{year}")
  end

  def add_rating(films)
    films.each do |film|
      rating_and_plot(film)
      film[:rating] = rating_and_plot[:rating]
      film[:plot] = rating_and_plot[:plot]
    end
  end

  def rating_and_plot(film)
    title = film[:ascii_dashed_title]
    year = film[:year]

    response = Unirest.get @url

    rating = response.body['imdbRating']
    plot = response.body['Plot']
    # (plot == nil || plot == "N/A") ?

    Hash.new { rating: rating, plot: plot }
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

end
