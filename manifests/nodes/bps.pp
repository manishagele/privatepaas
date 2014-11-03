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

# BPS cartridge node
node /[0-9]{1,12}.(default|manager|worker).bps/ inherits base {
  $docroot = "/mnt/${server_ip}/wso2bps-3.2.0"
  #require java
  class {'agent':}
  class {'bps':

        version            => '3.2.0',
        sub_cluster_domain => 'test',
        members            => undef,
        offset             => 0,
        hazelcast_port     => 4000,
        config_db          => 'xxxxx_bps_config',
        config_target_path => 'bps_config',
        maintenance_mode   => 'zero',
        depsync            => false,
        clustering         => true,
        cloud              => true,
        owner              => 'root',
        group              => 'root',
        target             => "/mnt/${server_ip}"

  }

#  Class['stratos_base'] -> Class['java'] -> Class['bps'] ~> Class['agent']
  Class['bps'] ~> Class['agent']
}
