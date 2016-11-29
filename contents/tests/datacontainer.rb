#!/usr/bin/env ruby

require_relative '../lib/datacontainer.rb'


dc = DataContainer.new('/Users/chuck.hilyard/projects/rldevops-plugin/contents')

key, value = dc.key_check("usa")
printf("return key & value: %s %s\n", key, value)
