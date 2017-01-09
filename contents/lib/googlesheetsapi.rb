
# test sheet #
# https://docs.google.com/spreadsheets/d/1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0/edit#gid=0
# spreadsheetId=1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0
# sheetId=0
#
# passable curl string
# https://sheets.googleapis.com/v4/spreadsheets/1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0/values/A2%3AB2?dateTimeRenderOption=SERIAL_NUMBER&majorDimension=DIMENSION_UNSPECIFIED&valueRenderOption=FORMATTED_VALUE&key=AIzaSyD59fSXFLZty357UAMlSrmBBj6qzKxFyEQ
#

require 'rest-client'
require 'json'

class GoogleSheetsAPI
    
  def initialize
    print "GoogleSheetsAPI::initialize\n"
    apikey = "AIzaSyD59fSXFLZty357UAMlSrmBBj6qzKxFyEQ"
    @uri = URI("https://sheets.googleapis.com/v4/spreadsheets/1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0/values/A2%3AB2?valueInputOption=FORMATTED_VALUE&key=AIzaSyD59fSXFLZty357UAMlSrmBBj6qzKxFyEQ")
    valuerange_json = { 
      :range => "A1:B2",
      }.to_json
    
    # build the connection to google
    # .pst(url, payload, headers = {}, &block)
    response = RestClient.put('https://sheets.googleapis.com/v4/spreadsheets/1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0/values/A2%3AB2&key=AIzaSyD59fSXFLZty357UAMlSrmBBj6qzKxFyEQ', valuerange_json, :content_type => 'text/plain')
    puts response.raw_headers
  end

  # this is specfic to the qa environment worksheet
  def update_qa_worksheet(range)
    print "GoogleSheetsAPI::update_qa_worksheet\n"
    spreadsheetId = "1JRfAZfmdtOHOWc3NofTkXVMofKoKs1xCWBFWo6P3wg0"
    sheetId = 0

    payload_hash = { "body" => "Rundeck executed #{ENV["RD_JOB_URL"]} against this ticket." }
    payload_json = payload_hash.to_json
    response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :payload => payload_json,
      :headers => { :content_type => 'application/json' },
      :user => "chuck.hilyard",
      :password => "asfkjasdf"
    )
  end

end
