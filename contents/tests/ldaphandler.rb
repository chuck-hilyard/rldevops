#!/usr/bin/env ruby

# argv: datacenter, runway, environment, change_to_platform

require_relative '../lib/ldaphandler.rb'


ldap = LdapHandler.new(ARGV[0], ARGV[1], ARGV[2])

nodes = ldap.search_qa_nodes("int3", "qa_nx1")

ldap.modify_qa_nodes(nodes, "bos")
