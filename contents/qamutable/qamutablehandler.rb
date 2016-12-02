
require 'net-ldap'
require_relative '../lib/ldaphandler.rb'


class QAMutableHandler
    def initialize(data_container, environment, platform, runway)
        print "loading QAMutableHandler\n"
        @environment = environment
        @platform = platform
        @runway = runway
        @host = "auth.wh.reachlocal.com"
        @username = "cn=PuppetMaster,dc=reachlocal,dc=com"
        @password = ""
        ldap_master_entry_exists?
        nodelist = collect_mutable_nodes
        update_mutable_nodes(nodelist)
    end

    private
    def ldap_master_entry_exists?
        print "in QAMutableHandler::ldap_master_entry_exists?\n"
        ldap = Net::LDAP.new(:host => @host, :port => 389, :auth => { 
            :method => :simple, 
            :username => @username,
            :password => @password 
            })
        if ldap.bind
            print "searching for master entry..."
              filter1 = Net::LDAP::Filter.eq("cn", @runway)
              filter2 = Net::LDAP::Filter.eq("environment", @environment)
              filter = Net::LDAP::Filter.join(filter1, filter2)
              treebase = "ou=hosts,dc=reachlocal,dc=com" 
              master = ldap.search(:base => treebase, :filter => filter)
        else
            abort("ldap auth FAILED")
        end 
        print "", ldap.get_operation_result.message, "\n"
    end

    def collect_mutable_nodes
      print "in QAMutableHandler::collect_mutable_nodes\n" 
        ldap = Net::LDAP.new(:host => @host, :port => 389, :auth => { 
            :method => :simple, 
            :username => @username,
            :password => @password 
            })
        if ldap.bind
          print "searching for nodes..."
          filter1 = Net::LDAP::Filter.eq("puppetVar", "runway=#{@runway}")
          filter2 = Net::LDAP::Filter.eq("environment", @environment)
          filter = Net::LDAP::Filter.join(filter1, filter2)
          treebase = "ou=hosts,dc=reachlocal,dc=com" 
          nodes = ldap.search(:base => treebase, :filter => filter)
          printf("found %i nodes to update\n", nodes.count)
          return nodes
        else
          abort("ldap auth FAILED")
        end
        print "", ldap.get_operation_result, "\n"
    end

    def update_mutable_nodes(nodelist)
        print "in QAMutableHandler::update_mutable_nodes\n"
        nodelist.each { |x|
          puts x.cn
        }
    end

    def update_spreadsheet
        print "updating qa spreadsheet\n"
    end

end

