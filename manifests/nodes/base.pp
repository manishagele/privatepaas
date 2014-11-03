# ----------------------------------------------------------------------------
#  Copyright 2005-2013 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------
#

# base node
node 'base' {

  #essential variables
  $local_package_dir    = '/mnt/packs'
  $mb_url		= 'failover://(tcp://10.251.30.116:61616,tcp://10.251.29.128:61616)'
  $mb_type		= 'activemq' #in wso2 mb case, value should be 'wso2mb'
  $cep_ip               = '10.251.29.124'
  $cep_port             = '7611'
  #$cep_url              = 'CEP_URL' #eg: tcp://10.100.2.32:7611,tcp://10.100.2.33:7611	
  $truststore_password  = 'wso2carbon'
  $java_distribution	= ''
  $java_name		= ''
  $java_home		= '/usr/java/jdk1.7.0_51/'
  $member_type_ip       = 'private'
  $lb_httpPort 		= '80'
  $lb_httpsPort 	= '443'
  $disable_sso		= 'false'
  $idp_hostname		= 'identity.integrateaz.gov'
  $idp_port		= '443'
  $enable_log_publisher = 'true'
  $server_ip            = $ipaddress
  $using_dns		= 'true'

  $greg_url		= 'https://registry.az.gov/registry'
  $registry_user        = 'xxxxx_governance'
  $registry_password    = 'eRo3UnX7'
  $registry_database    = 'xxxxx_governance'
  $registry_path        = '/_system/governance/integrate'
 
  $config_path		= '/_system/config/integrate'

  $userstore_user       = 'xxxxx_userstore'
  $userstore_password   = 'm34CsQ72'
  $userstore_database   = 'xxxxx_userstore'

  #credentials
  $admin_username       = 'admin@az.gov'
  $admin_password       = 'lFl4lWZp5v'

  $enable_email_users   = 'true'

 $mysql_server         = 'az11e01.integrateaz.gov'
  $mysql_port           = '3306'
  $max_connections      = '100000'
  $max_active           = '250'
  $max_wait             = '360000'

  # stats database
  $amstats_user         = 'xxxxx_apim_stats'
  $amstats_password     = 'E6cvzMIP'
  $amstats_database     = 'xxxxx_apim_stats'

  $bam_ip              = '10.251.29.105'
  $bam_hostname        = 'monitor.integrateaz.gov'
  $bam_port            = '7611'

  $mysql_conector	= 'mysql-connector-java-5.1.26-bin.jar'


  #following variables required only if you want to install stratos using puppet.
  #not supported in alpha version
  # Service subdomains
  #$domain               = 'stratos.com'
  #$as_subdomain         = 'autoscaler'
  #$management_subdomain = 'management'

  #$admin_username       = 'admin'
  #$admin_password       = 'admin123'
  #$puppet_ip            = '10.4.128.7'
  #$cc_ip                = '10.4.128.9'
  #$cc_port              = '9443'
  #$sc_ip                = '10.4.128.13'
  #$sc_port              = '9443'
  #$as_ip                = '10.4.128.8'
  #$as_port              = '9443'
  #$git_hostname        = 'git.stratos.com'
  #$git_ip              = '10.4.128.13'

  #$internal_repo_user     = 'admin'
  #$internal_repo_password = 'admin'

  #cartridge agent extension scripts
  # These values should be overriden as required by specific nodes
  $extension_instance_started             = 'instance-started.sh'
  $extension_start_servers                = 'start-servers.sh'
  $extension_instance_activated           = 'instance-activated.sh'
  $extension_artifacts_updated            = 'artifacts-updated.sh'
  $extension_clean                        = 'clean.sh'
  $extension_mount_volumes                = 'mount-volumes.sh'
  $extension_member_started               = 'member-started.sh'
  $extension_member_activated             = 'member-activated.sh'
  $extension_member_terminated            = 'member-terminated.sh'
  $extension_member_suspended             = 'member-suspended.sh'
  $extension_complete_topology            = 'complete-topology.sh'
  $extension_complete_tenant              = 'complete-tenant.sh'
  $extension_subscription_domain_added    = 'subscription-domain-added.sh'
  $extension_subscription_domain_removed  = 'subscription-domain-removed.sh'
  $extension_artifacts_copy               = 'artifacts-copy.sh'
  $extension_tenant_subscribed            = 'tenant-subscribed.sh'
  $extension_tenant_unsubscribed          = 'tenant-unsubscribed.sh'

  $agent_log_level = "INFO"
  $extensions_dir = '${script_path}/../extensions'

  $super_tenant_repository_path           = '/repository/deployment/server/'
  $tenant_repository_path                 = '/repository/tenants/'
  $package_repo         = '10.251.31.93'

  require stratos_base 
}
