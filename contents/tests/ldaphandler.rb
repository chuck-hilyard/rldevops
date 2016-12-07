#!/usr/bin/env ruby

# argv: datacenter, username, password 

require_relative '../lib/ldaphandler.rb'


runway = "int3"
environment = "qa_nx1"
change_to_platform = "jpn"

ldap = LdapHandler.new(ARGV[0], ARGV[1], ARGV[2])

nodes = ldap.search_qa_nodes(runway, environment)

ldap.modify_qa_nodes(nodes, change_to_platform)



