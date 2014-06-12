require 'net/http'
require 'nokogiri'

##
# Represents the elo calculator
class Elocalculator
  attr_accessor :html_file
  attr_accessor :elo_hash
  attr_accessor :avg_goals
  attr_accessor :html_doc
  attr_accessor :table_selector
  attr_accessor :found_html

  def initialize
    @html_file      = 'eloratings.html'
    @html_uri       = URI('http://www.eloratings.net/world_cup.html')
    @table_selector = 'table[bordercolor="white"][border="border"]
    [cellspacing="0"][frame="void"][rules="groups"]'
    @elo_hash       = {}
    @avg_goals      = 2.27
    @found_html     = nil
  end

  ##
  # Checks if there is a elorating
  def html_exist
    File.file?(@html_file)
  end

  ##
  # Downloads elorating
  def download_html
    html      = Net::HTTP.get(@html_uri)
    html_file = File.open(@html_file, 'w')
    begin
      html_file.write(html)
    ensure
      html_file.close unless html_file.nil?
    end
  end

  ##
  # Parses html
  def parse_html
    @html_doc = Nokogiri::HTML(File.open(@html_file, 'r'))
  end

  ##
  # Searches the dom for the elorating table
  def search_dom
    @found_html = @html_doc.css(@table_selector)
  end

  ##
  # Read values and put them in a hash
  def read_values
    @found_html.css('tr:not([class])').each do |item|
      country   = item.css('a').inner_text.strip
      rating = item.css('td')[3].inner_text.strip.to_i
      @elo_hash.store(country, rating)
    end
  end

  ##
  # highest in hash
  def highest
    @elo_hash.max_by { | _country, rating | rating }
  end

  ##
  # lowest in hash
  def lowest
    @elo_hash.min_by { | _country, rating | rating }
  end

  ##
  # max_difference
  def max_difference
    highest[1] - lowest[1]
  end

  ##
  # calculate winner
  def calculate_match(country1, country2)
    diff1 = elo_hash[country1] - lowest[1]
    diff2 = elo_hash[country2] - lowest[1]
    cupwinratio1 = diff1.to_f / max_difference.to_f
    cupwinratio2 = diff2.to_f / max_difference.to_f
    goals1 = (cupwinratio1 / (cupwinratio1 + cupwinratio2) * avg_goals).round
    goals2 = (cupwinratio2 / (cupwinratio1 + cupwinratio2) * avg_goals).round
    { country1: country1, country2: country2, goals1: goals1, goals2: goals2,
      matchwinratio1: (cupwinratio1 / (cupwinratio1 + cupwinratio2)).round(3),
      matchwinratio2: (cupwinratio2 / (cupwinratio1 + cupwinratio2)).round(3),
      winner: get_winner(goals1, goals2, country1, country2) }
  end

  ##
  # get winner
  def get_winner(goals1, goals2, country1, country2)
    if goals1 == goals2
      'tie'
    elsif goals1 < goals2
      country2
    else
      country1
    end
  end
end
