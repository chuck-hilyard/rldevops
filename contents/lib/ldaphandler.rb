# this is really tailored to the qamutable code.  making this more generic
# for use by other apps is not yet in the timetable.

require 'net-ldap'

class LdapHandler

    def initialize(datacenter)
      print "LdapHandler::initialize\n"
      # credentials should be moved to the datacontainer
      username = "cn=PuppetMaster,dc=reachlocal,dc=com"
      password = "Pr0j3ct_2501"
      host = "auth.#{datacenter}.reachlocal.com"
      print "opening connection to #{host}\n"
      @ldap = Net::LDAP.new(:host => host, :port => 389, :auth => { :method => :simple,
                                                                    :username => username,
                                                                    :password => password })
    end

    def search_qa_nodes(runway, environment)
      print "LdapHandler::search_qa_nodes\n"
      if @ldap.bind
        print "ldap auth success\n"
        filter1 = Net::LDAP::Filter.eq("puppetVar", "runway=#{runway}")
        filter2 = Net::LDAP::Filter.eq("environment", environment)
        filter = Net::LDAP::Filter.join(filter1, filter2)
        treebase = "ou=hosts,dc=reachlocal,dc=com"
        nodes = @ldap.search(:base => treebase, :filter => filter) 
        printf("found %i nodes\n", nodes.count)
        return nodes
      else
        abort("ldap auth FAILED")
      end
      print "", @ldap.get_operation_result.message, "\n"
    end

    def modify_qa_nodes(nodes, change_to_platform)
        print "LdapHandler::modify_qa_nodes\n"
        nodes.each { |x|
          printf("modifying %s\n", x.cn)
          #operations = [[:replace, :puppetVar, ["platform=#{change_to_platform}"]]]
          #@ldap.modify(:dn => x.dn, :operations => operations)
          #print "", @ldap.get_operation_result.message, "\n"
        }
    end

    def add_qa_nodes
        print "adding ldap entry\n"
    end

    def delete_qa_nodes
        print "deleting ldap entry\n"
    end

end
