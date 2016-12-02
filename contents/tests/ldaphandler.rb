#!/usr/bin/env ruby

# argv: datacenter, runway, environment, change_to_platform

require_relative '../lib/ldaphandler.rb'


ldap = LdapHandler.new(ARGV[0])

nodes = ldap.search_qa_nodes(ARGV[1], ARGV[2])

ldap.modify_qa_nodes(nodes, ARGV[3]) 
