# this will load our environment metadata into an object.  
# 
# the rl environment (datacenters, endpoints, environments) are managed via puppet.  use puppet to
# create a config file.  lib/datacontainer.json
#  

require 'json'

class DataContainer

    # we make these available to other objects 
    attr_reader :install_dir, :key, :action, :configjson

    def initialize(x) 
        # this const is used for file system access elsewhere
        @install_dir = x

        # available environments, platforms, etc. will be managed by puppet
        load_environment_config

        # check the args passed from the cli/rundeck and performa a quick sanity
        # check against those we loaded from the config file.
        validate_arguments
    end

    # this is our workhorse.  allow the client to pass a key (usually from the cli/gui args) and verify the key as existing
    # and returning TRUE if it exists, OR returning a value (key, value) associated with it
    #
    # there could be either hashes or arrays, let's check both
    def key_check(key)
        print "in DataContainer::key_check\n"        
        masterkeys = @configjson.keys
            masterkeys.each { |masterkey|

                # search any hashes we have
                if @configjson[masterkey].is_a?(Hash)
                  then
                  @configjson[masterkey].each do |k,v| 
                    if @configjson[masterkey].key?(key)
                      print "found #{key} in #{@configjson[masterkey]}\n"
                      return key, @configjson[masterkey][key] 
                    else 
                      print "#{key} not found #{@configjson[masterkey]}\n"
                    end
                  end

                # search any arrays we have
                elsif @configjson[masterkey].is_a?(Array) 
                  @configjson[masterkey].each do |k,v| 
                    if @configjson[masterkey].include?(key)
                      print "found #{key} in #{@configjson[masterkey]}\n"
                      return TRUE
                    else 
                      print "#{key} not found #{@configjson[masterkey]}\n"
                    end
                  end

                else 
                  print "what?\n"
                end
            }
    end

    private
    # read the json configuration file.  it should be managed by puppet which manages the global configuration and environments
    def load_environment_config
        configfilename = "#{install_dir}/lib/datacontainer.json"
        configfile = File.read(configfilename)
        @configjson = JSON.parse(configfile)
        #puts JSON.pretty_generate(@confighash)
    end

    # simplistic validation of arguments passed against those loaded from the environment
    # this should be moved into its own class, good enough, for now.
    # 
    def validate_arguments
        print "DataContainer::validating KEY\n"
        case ARGV[0].downcase
        when 'jira', 'lb', 'mutable'
          return 
        else
          abort("invalid KEY, aborting")
        end

    end

end
