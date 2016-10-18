# a shared authencation module which ensures that if credentials aren't set we'll go get 'em
#
# authentication sources;
# user input
# passmgr
#
# authentication types;
# active directory/ldap
# local to target
# local rundeck json file (this should be very limited)
# common 'rundeck' user (these users should be setup in AD or local to target) 
#   and should have multiple levels of access


class AuthenticationHandler

    def initialize
        print "AuthenticationHandler object initialization\n"
        @username 
        @password
    end

    def called_from
        # if we're called from the command line we have the option of requesting the username
        # and password from the user.  can't do that when called from rundeck
        case ENV['JOB_SOURCE'] 
            when "devopscli"
                print "called from command line\n"
            else
                print "called from RunDeck\n"
        end
    end

    def call_passmanager
        print "getting username/password from passmgr\n"
    end

    def set_credentials
        print "depending on how we're called (cli or rundeck)\n"
        print "and what job we're executing, grab credentials.\n"
        print "use the builtin credentials first, only prompt\n"
        print "if we must\n"
        print "does the target job use the calling user's AD credentials\n"
        print "or the shared rundeck users credentials?"
        # 
        # we should use a template, here
        #
        # examples
        # the netscaler loadbalancers utilize local accounts on each $dc's pair
        # the jira api doesn't require credentials for ticket lookups
        # the jira api DOES require user/AD credentials to update tickets with comments - perhaps we can use a rundeck
        #   shared account and utilize the rundeck built-in variable for the calling user
    end

    def check_credentials
        print "verify that username and password are set in the current object\n"
    end

    # we only request credentials if the user has called from the CLI *and* username / password were not
    # populated elsewhere
    def get_user_input
        print "username: "
        username = STDIN.gets.chomp

        print "password: "
        password = STDIN.noecho(&:gets).chomp
    end

end
