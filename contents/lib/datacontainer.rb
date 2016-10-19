# this will load our environment metadata into an object.  
# 
# the rl environment (datacenters, endpoints, environments) are managed via puppet.  use puppet to
# create a config file.  lib/datacontainer.json
#  

require 'json'

class DataContainer

    # we make these available to other objects 
    attr_reader :INSTALL_DIR, :key, :action

    def initialize(install_dir) 
        print "DataContainer object initialization\n"

        # this const is used for file system access elsewhere
        @INSTALL_DIR = install_dir

        if ARGV.length < 2
            abort("Insufficient arguments, aborting")
        else
            # available environments, platforms, etc. will be managed by puppet
            load_environment_config

            # check the args passed from the cli/rundeck and performa a quick sanity
            # check against those we loaded from the config file.
            validate_arguments
        end
    end

private
    # read the json configuration file.  it's managed by puppet which manages the global configuration and environments
    def load_environment_config
        configfile = File.read('lib/datacontainer.json')
        @confighash = JSON.parse(configfile)
        #puts JSON.pretty_generate(@confighash)
    end

    # this should be moved into its own class
    #
    # simplistic validation of arguments passed against those loaded from the environment
    def validate_arguments
        print "DataContainer::validating KEY\n"
        case ARGV[0].downcase
        when 'jira', 'lb'
            @key = ARGV[0]
            print "DataContainer::validating ACTION\n"
            case ARGV[1].downcase
                when 'create', 'check'
                    @action = ARGV[1]
                    return
                when 'add', 'remove'
                else
                    abort("invalid ACTION, aborting")
                end
        else
            abort("invalid KEY, aborting")
        end

    end

end
