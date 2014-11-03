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
# Class activemq::params
#
# This class manages activemq parameters
#
# Parameters:
#
# Usage: Uncomment the variable and assign a value to override the wso2.pp value
#
#

class activemq::params {
  $host_name 		= 'broker.integrateaz.gov'
  $local_package_dir    = '/mnt/packs'
  $installation	        = '/mnt/install'

  $mysql_jar		= 'mysql-connector-java-5.1.26-bin.jar'

  # variables
  $host_user		= 'root'

  $activemq_db		= 'aesp_activemq'
  $activemq_user	= 'aesp_activemq'
  $activemq_pass	= '4jrowwjw'

}
