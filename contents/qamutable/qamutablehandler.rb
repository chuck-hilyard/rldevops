

require 'net-ldap'
# this isn't in use, i'll move this functionality to it's own class, later
require_relative '../lib/ldaphandler.rb'

class QAMutableHandler
    def initialize(data_container, environment, platform, runway)
        print "loading QAMutableHandler\n"
        @environment = environment
        @platform = platform
        @runway = runway
        @host = "auth.wh.reachlocal.com"
        @username = "cn=PuppetMaster,dc=reachlocal,dc=com"
        @password = "*********"
        ldap_master_entry_exists?
        collect_mutable_nodes
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
            print "ldap auth success\n"
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
          print "ldap auth success\n"
          print "searching for nodes..."
          filter1 = Net::LDAP::Filter.eq("puppetVar", "runway=#{@runway}")
          filter2 = Net::LDAP::Filter.eq("environment", @environment)
          filter = Net::LDAP::Filter.join(filter1, filter2)
          treebase = "ou=hosts,dc=reachlocal,dc=com" 
          ldap.search(:base => treebase, :filter => filter) { |results|   
            puts "DN: #{results.dn}" 
            } 
        else
          abort("ldap auth FAILED")
        end
        print "", ldap.get_operation_result.message, "\n"
    end

    def update_ldap
        print "in QAMutableHandler::update_ldap\n"
    end

    def update_spreadsheet
        print "updating qa spreadsheet\n"
    end

end

