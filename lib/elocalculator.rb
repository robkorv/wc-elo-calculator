require 'net/http'
require 'nokogiri'

##
# Represents the elo calculator
class Elocalculator
  attr_accessor :html_file

  def initialize
    @html_file      = 'eloratings.html'
    @html_uri       = URI('http://www.eloratings.net/world_cup.html')
    @table_selector = 'table[bordercolor="white"][border="border"]
    [cellspacing="0"][frame="void"][rules="groups"]'
    @elo_hash = {}
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
      eloscore = item.css('td')[3].inner_text.strip.to_i
      @elo_hash.store(country, eloscore)
    end
  end

  ##
  # Makes elo_hash readable, not writable from outside
  def elo_hash
    @elo_hash
  end
end
