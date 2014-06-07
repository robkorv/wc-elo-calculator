##
# This class represents the elo calculator
class Elocalculator
  ##
  # This method checks if there is a downloaded elorating
  def html_exist
    File.file?('../eloratings.html')
  end
end
