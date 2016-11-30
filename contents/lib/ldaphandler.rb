require 'net-ldap'

class LdapHandler

    def initialize
        print "loading LdapHandler module\n"
        # credentials should be moved to the datacontainer
        username = "cn=PuppetMaster,dc=reachlocal,dc=com"
        password = ""
    end

    def search
      print "searching ldap\n"
      ldap = Net::LDAP.new(:host => "auth.wh.reachlocal.com", :port => 389, :auth => { :username => @username, 
                                                                                       :passowrd => @password })
      if ldap.bind
        print "ldap auth success\n"
        filter1 = Net::LDAP::Filter.eq("cn", @runway)
        filter2 = Net::LDAP::Filter.eq("environment", @environment)
        filter = Net::LDAP::Filter.join(filter1, filter2)
        treebase = "ou=hosts,dc=reachlocal,dc=com"
        data = ldap.search(:base => treebase, :filter => filter)
      else
        abort("ldap auth FAILED")
      end
      print "", ldap.get_operation_result.message, "\n"
    end

    def modify
        print "modifying ldap\n"
    end

    def add
        print "adding ldap entry\n"
    end

    def delete
        print "deleting ldap entry\n"
    end

end
