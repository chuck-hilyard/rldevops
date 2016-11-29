
# the arguments being passed 
# [ mutable ]        [ qanx1|qacur ]         [ int1|int2 ] to [ ams|eur|gbr|jpn|aus ]

# check the request and make certain there's a master entry for the requested environment switch.  it
# should look something like this, this will be our "master"
# 
# dn: cn=int1,ou=qa_cur,ou=Hosts,dc=reachlocal,dc=com
# environment: qa_cur
# cn: int1
# objectClass: device
# objectClass: puppetClient
# objectClass: top
# puppetVar: platform=aus

# a node entry will look like
# dn: cn=facebookshim-int1-app02.qa.wh.reachlocal.com.1478291038.1a07027c.rlpc,ou=Hosts,dc=reachlocal,dc=com
# objectClass: device
# objectClass: puppetClient
# objectClass: top
# cn: facebookshim-int1-app02.qa.wh.reachlocal.com.1478291038.1a07027c.rlpc
# puppetClass: base
# puppetClass: apps_facebook_shim
# parentNode: default
# environment: qa_cur
# puppetVar: service=facebookshim
# puppetVar: sub=app
# puppetVar: runway=int1
# puppetVar: branch=qa_cur
# puppetVar: platform=aus

require 'net-ldap'
require_relative '../lib/ldaphandler.rb'

class QAMutableHandler
    
    def initialize(data_container)
        print "loading QAMutableHandler\n"
        check_ldap_master_entry
    end

    private
    def check_ldap_master_entry
        print "in QAMutableHandler::check_ldap\n"
        ldap = Net::LDAP.new(:host => "auth.wh.reachlocal.com", :port => 389, :auth => { 
            :method => :simple, 
            :username => "cn=PuppetMaster,dc=reachlocal,dc=com", 
            :password => "Pr0j3ct_2501" 
            })
        if ldap.bind
            print "ldap auth success\n"
            print "searching for base entry\n"
              filter1 = Net::LDAP::Filter.eq("cn", "int1")
              filter2 = Net::LDAP::Filter.eq("environment", "qa_nx1")
              filter = Net::LDAP::Filter.join(filter1, filter2)
              treebase = "ou=hosts,dc=reachlocal,dc=com" 
              ldap.search(:base => treebase, :filter => filter) { |entry|
                  puts "dn: #{entry.dn}"
                  entry.each { |attribute, values|
                      puts "  #{attribute}:"
                      values.each { |value|
                          puts "  --->#{value}"
                      }
                  }
              }

        else
            print "ldap auth FAILED\n"
        end 
    end

    def update_ldap
        print "in QAMutableHandler::update_ldap\n"
    end

    def update_spreadsheet
        print "updating qa spreadsheet\n"
    end

end

