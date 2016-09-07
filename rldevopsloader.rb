
require_relative 'lib/authenticationhandler.rb'
require_relative 'lib/datacontainer.rb'


class RLDevOpsLoader

    def initialize()
        print "main()\n"
        auth_handler = AuthenticationHandler.new 
        data_container = DataContainer.new
    end

end


rldevopsloader = RLDevOpsLoader.new
