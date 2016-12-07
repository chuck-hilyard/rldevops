
# test sheet #
# https://docs.google.com/spreadsheets/d/1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0/edit#gid=0
# spreadsheetId=1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0
# sheetId=0
#
# passable curl string
# https://sheets.googleapis.com/v4/spreadsheets/1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0/values/A2%3AB2?dateTimeRenderOption=SERIAL_NUMBER&majorDimension=DIMENSION_UNSPECIFIED&valueRenderOption=FORMATTED_VALUE&key=AIzaSyD59fSXFLZty357UAMlSrmBBj6qzKxFyEQ
#
require 'rest-client'

class GoogleSheetsAPI
    
  def initialize
    print "GoogleSheetsAPI::initialize\n"
    url = "https://docs.google.com/spreadsheets/d/"
    apikey = "AIzaSyD59fSXFLZty357UAMlSrmBBj6qzKxFyEQ"
    @uri = URI::HTTP.build({
      :host     => "docs.google.com",
      :path     => "/spreadsheets/d/",
      :port     => 443,
      :scheme   => "https",
      :fragment => ""
    })
  end

  def update_qa_worksheet(range)
    print "GoogleSheetsAPI::update_qa_worksheet\n"
    spreadsheetId = "1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0"
    sheetId = 0
  end

end
