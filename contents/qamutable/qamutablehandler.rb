
require_relative '../lib/ldaphandler.rb'

class QAMutableHandler

  def initialize(data_container, runway, environment, change_to_platform)
    print "QAMutableHandler::initialize\n"
    # hard coded, mutable environments in prod probably won't happen
    datacenter = "wh"
    @runway = runway
    @environment = environment
    @host = "auth.wh.reachlocal.com"
    username = "cn=PuppetMaster,dc=reachlocal,dc=com"
    password = ""
    ldaphandler = LdapHandler.new(datacenter, username, password)
    master_entry = ldaphandler.ldap_master_entry_exists?(runway, environment)
    nodelist = ldaphandler.search_qa_nodes(runway, environment)
    ldaphandler.modify_master_entry(master_entry, change_to_platform)
    ldaphandler.modify_qa_nodes(nodelist, change_to_platform)
  end

  def update_spreadsheet
    print "updating qa spreadsheet\n"
  end

end

