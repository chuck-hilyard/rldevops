#!/usr/bin/env ruby

require_relative '../lib/datacontainer.rb'


dc = DataContainer.new('/Users/chuck.hilyard/projects/rldevops-plugin/contents')
#puts dc.configjson['datacontainer']['platform_datacenter']["usa"]
puts dc.configjson['datacontainer']['platform_datacenter'].select { |h1| h1['key'] == 'usa'; } [1]

