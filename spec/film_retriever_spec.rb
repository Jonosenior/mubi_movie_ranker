require 'spec_helper'

describe FilmRetriever do
  subject(:retriever) { FilmRetriever }

  context '#current_mubi_films' do
    let(:films) { retriever.current_mubi_films }

    it 'returns 30 items' do
      expect(films.count).to eq(30)
    end

    it 'returns items with the expected keys' do
      films.each do |film|
        expect(film).to have_key(:title)
        expect(film).to have_key(:ascii_dashed_title)
        expect(film).to have_key(:year)
      end
    end
  end

  # it 'returns 30 items'
  #
  # context 'GET to /' do
  #   let(:response) { get '/' }
  #
  #   it 'returns status 200 OK' do
  #     expect(response.status).to eq 200
  #   end
  #
  #   it 'returns 30 Mubi film titles' do
  #     expect(response.body).to have_tag('a.film-title', count: 30)
  #   end
  # end
end
