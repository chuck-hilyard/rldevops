
require_relative 'lib/authenticationhandler.rb'
require_relative 'lib/datacontainer.rb'
require_relative 'lib/authorizationhandler.rb'


class RunTimeHandler

    def initialize
        print "loading objects\n"
        auth_handler = AuthenticationHandler.new 
        data_container = DataContainer.new
        authorization_handler = AuthorizationHandler.new
        exec_task(ARGV)
    end

    def exec_task(*args)
        args.each { |x| 
            print x 
        } 
    end


end


runtime = RunTimeHandler.new
