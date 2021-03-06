# this is really tailored to the qamutable code.  making this more generic over time...

require 'net-ldap'

class LdapHandler

  def initialize(datacenter, username, password)
    print "LdapHandler::initialize\n"
    host = "auth.#{datacenter}.reachlocal.com"
    print "opening connection to #{host}\n"
    @ldap = Net::LDAP.new(:host => host, :port => 389, :auth => { :method => :simple,
                                                                    :username => username,
                                                                    :password => password })
  end

  def ldap_master_entry_exists?(runway, environment)
    print "QAMutableHandler::ldap_master_entry_exists?\n"
     if @ldap.bind
       print "searching for master mutable ldap entry..."
       filter1 = Net::LDAP::Filter.eq("cn", runway)
       filter2 = Net::LDAP::Filter.eq("environment", environment)
       filter = Net::LDAP::Filter.join(filter1, filter2)
       treebase = "ou=hosts,dc=reachlocal,dc=com"
       master = @ldap.search(:base => treebase, :filter => filter)
       return master
     else
       abort("ldap auth FAILED")
     end
     if master.count < 1
       abort("master record not found, exiting")
     else
       print "", @ldap.get_operation_result.message, "\n"
     end
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
      if nodes.count < 1
        abort("nodes not found, exiting")
      else
        return nodes
      end
    else
      abort("ldap auth FAILED")
    end
    print "", @ldap.get_operation_result.message, "\n"
  end

  def modify_qa_nodes(nodes="devnull", change_to_platform)
      print "LdapHandler::modify_qa_nodes\n"
      nodes.each { |x|
        printf("updating %s\n", x.cn)
        x.puppetvar.each { |y|
          if y.match('platform=*')
            printf("  removing %s\n", y)
            operations = [[:delete, :puppetvar, y]]
            #@ldap.modify(:dn => x.dn, :operations => operations)
          end
        }
        printf("  adding platform=%s...", change_to_platform)
        #@ldap.add_attribute(x.dn, :puppetVar, "platform=#{change_to_platform}")
        print "", @ldap.get_operation_result.message, "\n"
      }
  end

  # this is identical to modify_qa_nodes, DRY it later
  def modify_master_entry(master_entry, change_to_platform)
    print "LdapHandler::modify_master_entry\n"
    master_entry.each { |x|
      printf("updating %s\n", x.dn) 
      #operations = [[:replace, :puppetVar, ["platform=#{change_to_platform}"]]]
      #@ldap.modify(:dn => x.dn, :operations => operations)
      #print "", @ldap.get_operation_result.message, "\n"
    }
  end
end
