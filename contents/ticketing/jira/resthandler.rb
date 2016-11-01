
# this rundeck plugin is responsible for verifying that a JIRA ticket is created for a particular change.
# the ticket should be a "CMR", cab approved, and with relevant text in the summary.
#
# Issue Type: Change Request
# Summary: regex("text")
# 
# CMR Status: "CAB-Approved", "Open", "Closed"
# JSON: "status": { "name":"Closed" } 
#
#

module JiraRestHandler

require 'json'
require 'base64'
require 'rest-client'

# *******************************************************************************
# build a basic uri object.  update the path local to the function for
# any functions that require it
def build_uri(ticketnumber)
    @uri = URI::HTTP.build({
        :host       => "tickets.reachlocal.com",
        :path       => "/rest/api/2/issue/#{ticketnumber}",
        :port       => "",
        :scheme     => "http",
        :fragment   => ""
    })
end


# *******************************************************************************
# check the number passed to us for proper syntax
#
# ticket/crm numbers are of the format [a-zA-Z]-[0-9999].  simple regex: ^[a-zA-Z]{1,10}-{1}[0-9]{1,4}$ 
def parse_ticket(ticketnumber)
    if /^[cC][mM][rR]-{1}[0-9]{1,4}$/.match(ticketnumber)
        ;
    else
        print "invalid CMR ticketnumber\n"
        exit 1
    end
end

# *******************************************************************************
# fetch the ticket from jira
# 
# example curl:
# curl -D- -u chuck.hilyard:$PASSWORD -X GET -H "Content-Type: application/json" "https://jira.reachlocal.com/rest/api/2/issue/APPOPS-21"
def call_rest_ticketstatus(ticketnumber)
    @uri.path = "/rest/api/2/issue/#{ticketnumber}"
    url = "https://tickets.reachlocal.com/rest/api/2/issue/#{ticketnumber}"
        begin
            # we don't need to pass credentials
            response = RestClient::Request.execute(:method => :get,  :url => url)
        rescue Exception => e
            puts e.message
            exit 1
        end
    # uncomment the following line to see the HTTP response code
    #print "response code:", response.code, "\n"
    response_json = JSON.parse(response)
    # uncomment the following line if you want to see the JSON output
    #puts JSON.pretty_generate(response_json)
    ticketstatus = response_json["fields"]["status"]["name"]
    case ticketstatus 
    when "CAB-Approved"
        print "ticket is CAB-Approved\n"
            # compare the ticket age to today's date, let's make sure people
            # aren't using old tickets
            maxticketage = 17
            ticketageraw = response_json["fields"]["created"].gsub("-", "")
            ticketage = ticketageraw.match(/^[0-9]{8}/)[0].to_i
            todaysdatevalue = Time.now.strftime("%Y%m%d") 
            tempa = todaysdatevalue.to_i
            tempc = tempa - ticketage
            if tempc.to_i <= maxticketage
                then
                    call_rest_updateticket(ticketnumber)
                    exit 0
                else
                    print "but the ticket is old, nice try.\n"
                    exit 1
                end
    else
        print "ticket is NOT CAB-Approved\n"
        exit 1
    end
end

private
# insert a comment into the ticket
def call_rest_updateticket(ticketnumber)
    #
    # example curl command
    # curl -D- -u chuck.hilyard -X POST --data '{ "body": "comment" }' -H "Content-Type: application/json" \
    # "https://jira.reachlocal.com/rest/api/2/issue/APPOPS-16/comment" 
    #
    print "adding a comment to ", ticketnumber, "\n"
    url = "https://tickets.reachlocal.com/rest/api/2/issue/#{ticketnumber}/comment"
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
    
# end module def 
end


