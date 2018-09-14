

class FilmRetriever

  def self.current_mubi_films

    @mubi_url = 'https://mubi.com/showing'
    @page = Nokogiri::HTML(open(@mubi_url))

    film_title_elements = @page.css('#page-region h2')
    film_year_elements = @page.css('#page-region h3')
    film_title_buttons = @page.css('#page-region a').select { |a| a['href'] if a['href']&.match(/showing/)}

    titles = film_title_elements.map { |a| a.text }
    years = film_year_elements.map { |b| b.text.match(/\d{4}/) }
    ascii_dashed_titles = film_title_buttons.map { |a|  a['href'].sub('/showing/', '') }

    films = (0..29).to_a.map do |i|
      { title: titles[i],
        year: years[i].to_s,
        ascii_dashed_title: ascii_dashed_titles[i]
      }
    end
  end
end
