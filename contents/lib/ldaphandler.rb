# this is really tailored to the qamutable code.  making this more generic
# for use by other apps isn't in the timetable.

require 'net-ldap'

class LdapHandler

    def initialize(datacenter)
      print "instantiating LdapHandler\n"
      # credentials should be moved to the datacontainer
      username = "cn=PuppetMaster,dc=reachlocal,dc=com"
      password = "**************************************************"
      host = "auth.#{datacenter}.reachlocal.com"
      print "opening connection to #{host}\n"
      @ldap = Net::LDAP.new(:host => host, :port => 389, :auth => { :method => :simple,
                                                                    :username => username,
                                                                    :password => password })
    end

    def search_qa_nodes(environment, runway)
      print "searching ldap\n"
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

    def modify_qa_nodes(nodes)
        print "modifying qa nodes\n"
        nodes.each { |x|
          printf("modifying %s", x.cn)
          operations = [[:replace, :puppetVar, ["runway=int1"]]]
          @ldap.modify(:dn => x.dn, :operations => operations)
          print "", @ldap.get_operation_result, "\n"
        }
    end

    def add_qa_nodes
        print "adding ldap entry\n"
    end

    def delete_qa_nodes
        print "deleting ldap entry\n"
    end

end
