
require_relative 'lib/authenticationhandler.rb'
require_relative 'lib/datacontainer.rb'
require_relative 'lib/authorizationhandler.rb'


class RunTimeHandler

    def initialize
        print "loading objects\n"
        auth_handler = AuthenticationHandler.new 
        data_container = DataContainer.new
        authorization_handler = AuthorizationHandler.new
    end

    def exec_task(args)
        print "args1: ", args[0], "\n"
        case args[0]
        when 'jira'
            include 'ticketing/jira/resthandler.rb'
        else
            abort("not sure what to exec_task")
        end
    end


end


runtime = RunTimeHandler.new
runtime.exec_task(ARGV)
