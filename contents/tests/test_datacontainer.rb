#!/usr/bin/env ruby

require_relative '../lib/datacontainer.rb'


dc = DataContainer.new('/Users/chuck.hilyard/projects/rldevops-plugin/contents')

# this works do not delete
#puts dc.configjson['platform_datacenter']["usa"]

dc.key_check("usa")
