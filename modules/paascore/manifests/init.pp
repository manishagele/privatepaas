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
class paascore ( 
  $config_db          = undef,
  $config_target_path = 'sm_config',	
  $owner              = 'root',
  $group              = 'root',
  $target             = "/opt/${server_ip}", ) inherits params {

  $deployment_code = 'paascore'
  $service_code    = "wso2-private-paas-4.0.0-installer"
  $carbon_home     = "${target}/${service_code}"

  $service_templates = [
      'boot.sh',
      'conf.sh',
      'resources/dbscripts/config.sql',
      'resources/dbscripts/registry.sql',
      'stratos-installer/clean.sh',
      'stratos-installer/setup.sh',
      'stratos-installer/conf/setup.conf',
      'stratos-installer/config/all/bin/stratos.sh',
      'stratos-installer/config/all/repository/conf/carbon.xml',
      'stratos-installer/config/all/repository/conf/event-broker.xml',
      'stratos-installer/config/all/repository/conf/cartridge-config.properties',
      'stratos-installer/config/all/repository/conf/autoscaler.xml',
      'stratos-installer/config/all/repository/conf/log4j.properties',
      'stratos-installer/config/all/repository/conf/tomcat/catalina-server.xml',
      'stratos-installer/config/all/repository/conf/activemq/jndi.properties',
      'stratos-installer/config/all/repository/conf/user-mgt.xml',
      'stratos-installer/config/all/repository/conf/registry.xml',
      'stratos-installer/config/all/repository/conf/cloud-controller.xml',
      'stratos-installer/config/all/repository/conf/etc/logging-config.xml',
      'stratos-installer/setup_bam_logging.sh',        
 ]

  tag($service_code)

  paascore::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
    stratos_pack => $stratos_pack,
    installation => $installation,
    mysql_jar	 => $mysql_jar,
  }

  paascore::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => paascore::initialize[$deployment_code],
  }

  paascore::push_templates {
    $service_templates:
      directory => $deployment_code,
      target    => $carbon_home,
      require   => paascore::deploy[$deployment_code];
  }

  paascore::start { $deployment_code:
    owner   => $owner,
    target  => $carbon_home,
    require => [
      paascore::push_templates[$service_templates],
    ];
  }


}
