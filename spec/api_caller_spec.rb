require 'spec_helper'

describe APICaller do
  before(:all) do
    @films = FilmRetriever.current_mubi_films
    @api = APICaller.new(@films)
  end

  context 'After calling #add_api_info_to_films' do
    before(:all) do
      @api.add_api_info_to_films
      @films = @api.films
    end

    it 'adds a rating to each film' do
      @films.each do |film|
        expect(film).to have_key(:rating)
      end
    end
    it 'adds a plot to each film' do
      @films.each do |film|
        expect(film).to have_key(:plot)
      end
    end
  end

  context '#rating_and_plot' do
    let(:film) { { ascii_dashed_title: 'star_wars', year: '1977' } }
    let(:rating_and_plot) { @api.return_rating_and_plot(film) }

    it 'returns a rating for a film' do
      expect(rating_and_plot[:rating]).to be_a(String)
    end

    it 'returns the rating as a stringified float' do
      rating = rating_and_plot[:rating]
      expect(rating.to_f.to_s).to eq(rating)
    end

    it 'returns a plot for the film' do
      expect(rating_and_plot[:plot]).to be_a(String)
    end
  end
end
