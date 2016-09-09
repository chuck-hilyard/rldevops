
class SecurityHandler

    def initialize
        print "SecurityHandler - object initialization\n"
        print "SecurityHandler - ensure any production executing requires a JIRA ticket\n"
        ## check DataContainer::environment if 'prod'
        # then check DataContainer::jira_ticket_number
        ## need to refactor ticketing/jira/resthandler.rb to support object creation
    end

end
