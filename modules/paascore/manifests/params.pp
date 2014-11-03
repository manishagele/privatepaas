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
# Class paascore::params
#
# This class manages paascore parameters
#
# Parameters:
#
# Usage: Uncomment the variable and assign a value to override the wso2.pp value
#
#

class paascore::params {
  $local_package_dir    = '/mnt/packs'
  $installation	        = '/mnt/install'
  $mb_url               = 'failover\:\/\/\(tcp\:\/\/10.251.30.116\:61616\,tcp\:\/\/10.251.29.128\:61616\)'

  $stratos_pack 	= 'apache-stratos-4.0.0-wso2v1'
  $mysql_jar		= 'mysql-connector-java-5.1.26-bin.jar'

  # Service subdomains
  $domain               = 'wso2.com'
  $as_subdomain         = 'paascore'
  $management_subdomain = 'management'

  # variables
  $host_user		= 'root'
  $puppet_ip		= '10.251.29.141'
  $puppet_host		= 'puppetmaster.integrateaz.gov'  

  $iaas			= 'ec2'
  $region		= 'us-west-1'
  $ec2_identity		= 'AKIAI3J4ZHAGFRDWXMQA'
  $ec2_credentials	= 'RwOAOl/b0n1k3WOxlQ3iFXw/3W4RDQ825v2h6/ff'
  $ec2_owner_id		= '558265680279'
  $ec2_keypair_name	= 'r2-azintigrate1'
  $ec2_availability_zone = 'us-west-1c'
  $ec2_security_group_ids = 'sg-f747a798'
  $ec2_subnet_id	= 'subnet-7d094415'
  $ec2_associate_public_ip_address = 'true'

  # MySQL server configuration details
  #$mysql_server         = 'ec2-54-254-43-232.ap-southeast-1.compute.amazonaws.com'
  #$mysql_port           = '3306'
  #$max_connections      = '100000'
  #$max_active           = '150'
  #$max_wait             = '360000'

  $config_user		= 'aesp_sm'
  $config_password	= 'fCYm2ycx'

  # Depsync settings
  $svn_user             = 'wso2'
  $svn_password         = 'wso2123'

  # Auto-scaler
  $auto_scaler_epr      = 'http://xxx:9863/services/AutoscalerService/'

  #LDAP settings 
  $ldap_connection_uri      = 'ldap://localhost:10389'
  $bind_dn                  = 'uid=admin,ou=system'
  $bind_dn_password         = 'adminpassword'
  $user_search_base         = 'ou=system'
  $group_search_base        = 'ou=system'
  $sharedgroup_search_base  = 'ou=SharedGroups,dc=wso2,dc=org'

  #Proxy ports
  $http_proxy_port             = '80'
  $https_proxy_port             = '443'
}
