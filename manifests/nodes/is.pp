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

# IS cartridge node
node /[0-9]{1,12}.(default|manager|worker).identity/ inherits base {
  $docroot = "/mnt/${server_ip}/wso2is-5.0.0"
#  require java
  class {'agent':}
  class {'is':

        version            => '5.0.0',
        sub_cluster_domain => 'test',
        members            => undef,
        offset             => 0,
        hazelcast_port     => 4000,
        config_db          => 'xxxxx_is_config',
        config_target_path => 'is_config',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => true,
        cloud              => true,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"

  }

Class['is'] ~> Class['agent']

}
