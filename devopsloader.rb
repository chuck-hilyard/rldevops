
require_relative 'lib/authenticationhandler.rb'
require_relative 'lib/datacontainer.rb'
require_relative 'lib/securityhandler.rb'


class DevOpsLoader

    def initialize
        print "main()\n"
        auth_handler = AuthenticationHandler.new 
        data_container = DataContainer.new
        security_handler = SecurityHandler.new
    end

end


rldevopsloader = DevOpsLoader.new
