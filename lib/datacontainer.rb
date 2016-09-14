# this will load our environment metadata into an object.  
# 
# the rl environment (datacenters, endpoints, environments) are managed via puppet.  use puppet to
# create a config file for us to import
# 

require 'JSON'

class DataContainer

    def initialize 
        print "DataContainer object initialization\n"
        if ARGV.length < 1
            abort("nothing to do w/o arguments")
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

    def validate_arguments
        print "DataContainer - validating arguments\n"
        #@request.body = { :login => { :username => "#{@username}", :password => "#{@password}" } }.to_json
        index_hash = [ "jira", "lb", "node" ]
        ARGV.each { |x| print "x: ", x, "\n" }
    end

end
