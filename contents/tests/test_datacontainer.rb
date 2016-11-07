#!/usr/bin/env ruby

require_relative '../lib/datacontainer.rb'


dc = DataContainer.new('/Users/chuck.hilyard/projects/rldevops-plugin/contents')

# this works do not delete
#puts dc.configjson['platform_datacenter']["usa"]

# even better.  let's pass the key we'd like to check and see if it returns true (the key is valid) or false (the key is invalid)
# OR a return value (key, value)
value = dc.key_check("usa")
print "value: ", value, "\n"
