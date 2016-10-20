
# this class is included in every invocation of this toolset 
# 
# the idea is to force a ticket check on any 'prod' action.  'pre-prod' ticket checks are optional.
#
# there isn't much here as of yet...soon.

class AuthorizationHandler

    attr_reader :authorized

    def initialize
        print "AuthorizationHandler object initialization\n"
        ## check DataContainer::environment if 'prod'
        # then check DataContainer::jira_ticket_number
        @authorized = 0
    end

end
