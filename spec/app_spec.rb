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

    it 'links to Mubi in each film title' do
      expect(response.body.to have_link(href: '/mubi/')
    end
  end
end
