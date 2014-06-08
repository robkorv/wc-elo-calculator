require 'net/http'

##
# Represents the elo calculator
class Elocalculator
  def initialize
    @html_file = 'eloratings.html'
    @html_uri  = URI('http://www.eloratings.net/world_cup.html')
  end

  ##
  # Checks if there is a downloaded elorating
  def html_exist
    File.file?(@html_file)
  end
  ##
  # Checks if there is a downloaded elorating
  def download_html
    html      = Net::HTTP.get(@html_uri)
    html_file = File.open(@html_file, 'w')
    begin
      html_file.write(html)
    ensure
      html_file.close unless html_file.nil?
    end
  end
end
