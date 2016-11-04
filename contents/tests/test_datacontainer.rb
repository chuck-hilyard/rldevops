#!/usr/bin/env ruby

require_relative '../lib/datacontainer.rb'


dc = DataContainer.new('/Users/chuck.hilyard/projects/rldevops-plugin/contents')

# this works, but not ideal.  don't really need a block over which to iterate
#dc.configjson['datacontainer']['platform_datacenter'].select { |h1| puts h1['usa'] } 

puts dc.configjson['platform_datacenter']["usa"]
