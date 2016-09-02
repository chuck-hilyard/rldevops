
require_relative 'lib/authentication.rb'


class RLDevOps

    def initialize()
        print "main()\n"
        auth_handler = AuthenticationHandler.new 
    end

end


rldevops = RLDevOps.new
