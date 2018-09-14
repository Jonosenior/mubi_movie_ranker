require 'spec_helper'

describe MubiMovieRanker do
  let(:app) { MubiMovieRanker.new }

  context 'GET to /' do
    let(:response) { get '/' }

    it 'returns status 200 OK' do
      expect(response.status).to eq 200
    end

    it 'returns 30 Mubi film titles' do
      expect(response.body).to have_tag('a.film-title', count: 30)
    end
  end
end
