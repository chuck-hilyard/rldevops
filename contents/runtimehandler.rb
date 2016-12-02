#
# options passed from rundeck are of the format RD_OPTION_SOMENAME  
#

require_relative 'lib/authenticationhandler.rb'
require_relative 'lib/datacontainer.rb'
require_relative 'lib/authorizationhandler.rb'
require_relative 'ticketing/jira/resthandler.rb'
require_relative 'qamutable/qamutablehandler.rb'


class RunTimeHandler

    attr_reader :data_container

    def initialize
        install_dir = Kernel::__dir__
        @data_container = DataContainer.new(install_dir)
        auth_handler = AuthenticationHandler.new 
        authorization_handler = AuthorizationHandler.new
    end

    def exec_task(args)
        case args[0]
        when 'jira'
            extend JiraRestHandler
            ticketnumber = ENV["RD_OPTION_TICKETNUMBER"]
            parse_ticket(ticketnumber)
            build_uri(ticketnumber)
            call_rest_ticketstatus(ticketnumber)
        when 'mutable'
            environment = ENV["RD_OPTION_ENVIRONMENT"]
            platform = ENV["RD_OPTION_PLATFORM"]
            runway = ENV["RD_OPTION_RUNWAY"]
            qamutable = QAMutableHandler.new(data_container, runway, environment, platform)
        else
            abort("not sure what to exec_task")
        end
    end


end


runtime = RunTimeHandler.new
runtime.exec_task(ARGV)
