
# this class is included in every invocation of this toolset 
# 
# a determination must be made for whether this is a prod or pre-prod action.  any prod action must have a 
# ticket associated with it.  thusly, this class.

class SecurityHandler

    def initialize
        print "SecurityHandler - object initialization\n"
        print "SecurityHandler - ensure any production execution requires a JIRA ticket\n"
        ## check DataContainer::environment if 'prod'
        # then check DataContainer::jira_ticket_number
        ## need to refactor ticketing/jira/resthandler.rb to support object creation
    end

end
