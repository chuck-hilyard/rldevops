
# this class is included in every invocation of this toolset 
# 
# there isn't much here as of yet...soon.

class AuthorizationHandler

    attr_reader :authorized

    def initialize
        print "AuthorizationHandler object initialization\n"
        ## check DataContainer::environment if 'prod'
        # then check DataContainer::jira_ticket_number
        ## need to refactor ticketing/jira/resthandler.rb to support object creation
        @authorized = 0
    end

end
