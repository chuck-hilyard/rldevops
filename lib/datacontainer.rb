# this will load our environment configuration into an object.  
# 
# use puppet to manage the .json file
# 

require 'JSON'

class DataContainer

    def initialize(*args) 
        print "DataContainer object initialization\n"
        if args.length < 1
            abort("can't run w/o arguments")
        else
            print "loading environment values\n"
            configfile = File.read('lib/datacontainer.json')
            confighash = JSON.parse(configfile)
            puts JSON.pretty_print(confighash)
            # load environments hash from json here
            
            print "processing arguments\n"
            # check the args passed against the hash loaded from the json config file
        end

    end

end
