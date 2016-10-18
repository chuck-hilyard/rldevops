
require_relative 'lib/authenticationhandler.rb'
require_relative 'lib/datacontainer.rb'
require_relative 'lib/authorizationhandler.rb'


class RunTimeHandler

    def initialize
        print "RunTimeHandler.initialize()\n"
        auth_handler = AuthenticationHandler.new 
        data_container = DataContainer.new
        authorization_handler = AuthorizationHandler.new
    end

end


runtime = RunTimeHandler.new
