
# a shared authencation module for the peer rundeck plugins
# stubbing this out.
#
#

class RundeckAuthencation()
    {
    def initialize
        print "you've created a RundeckAuthentication object\n"
    end

    def calledfrom
        print "were we called from rundeck or the cli?\n"
    end

    def setcredentials
        print "depending on how we're called (cli or rundeck)\n"
        print "and what job we're executing, grab credentials.\n"
    end
    }

    def targetjob
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

    def requestcreds
        print "called from the command line, you'll need to supply your username/password\n"
        print "username: "
        STDIN.gets.chomp

        print "password: "
        password = STDIN.noecho(&:gets).chomp
    end

