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
# Class: bam
#
# This class installs WSO2 bam
#
# Actions:
#   - Install WSO2 bam
#
# Requires:
#
# Sample Usage:
#

class bam (
  $version            = '2.4.1',
  $sub_cluster_domain = 'bam',
  $members            = false,
  $offset             = 0,
  $hazelcast_port     = 4000,
  $config_db          = 'governance',
  $config_target_path = 'config/as',	
  $maintenance_mode   = true,
  $depsync            = false,
  $clustering         = false,
  $cloud              = true,
  $owner              = 'root',
  $group              = 'root',
  $target             = "/mnt/${server_ip}",
) inherits params {

  $deployment_code = 'bam'
  $carbon_version  = $version
  $service_code    = 'bam'
  $carbon_home     = "${target}/wso2${service_code}-${carbon_version}"

  $service_templates = [ 
      'conf/axis2/axis2.xml',
      'conf/carbon.xml',
      'conf/datasources/bam-datasources.xml',
      'conf/datasources/master-datasources.xml',
      'conf/registry.xml',
      'conf/etc/cassandra.yaml',
      'conf/etc/hector-config.xml',
      'conf/etc/summarizer-config.xml',
      'conf/etc/logging-config.xml',
      'conf/advanced/hive-site.xml',
      'conf/tomcat/catalina-server.xml',
      'conf/user-mgt.xml',
      'conf/log4j.properties',
  ]

  tag($service_code)

  bam::clean { $deployment_code:
    mode   => $maintenance_mode,
    target => $carbon_home,
  }

  bam::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
    require   => bam::clean[$deployment_code],
  }

  bam::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => bam::initialize[$deployment_code],
  }

  bam::push_templates {
    $service_templates:
      target    => $carbon_home,
      directory => $deployment_code,
      require   => bam::deploy[$deployment_code];
  }

  bam::start { $deployment_code:
    owner   => $owner,
    target  => $carbon_home,
    require => [
      bam::initialize[$deployment_code],
      bam::deploy[$deployment_code],
      bam::push_templates[$service_templates],
      ],
  }

}
