require 'spec_helper'

describe MubiMovieRanker do
  let(:app) { MubiMovieRanker.new }

  context 'GET to /' do
    let(:response) { get '/' }

    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end

    it 'contains 30 film titles' do
      expect(response.body).to have_tag('a.film-title', count: 30)
    end

    it 'displays a rating for each film' do
      expect(response.body).to have_tag('p.rating', count: 30)
    end

    it 'displays the plot for each film'
    it 'displays each film rating as decimal or "n/a"'
    it 'links to Mubi in each film title'
    it 'does not contain a broken link'
    it 'links to the about page'
    it 'has same title font for Navbar and Jumbotron'
    it 'displays highest-rated film at the top'
    it 'displays films with no rating at the bottom'
  end
end
