#!/usr/bin/env ruby


require_relative '../lib/ldaphandler.rb'


ldap = LdapHandler.new(ARGV[0])

nodes = ldap.search_qa_nodes("qa_nx2","int3")

ldap.modify_qa_nodes(nodes)
