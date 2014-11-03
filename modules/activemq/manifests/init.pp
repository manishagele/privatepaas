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
class activemq ( 
  $owner              = 'root',
  $group              = 'root',
  $target             = "/opt/${server_ip}", ) inherits params {

  $deployment_code = 'activemq'
  $service_code    = "apache-activemq-5.9.1"
  $carbon_home     = "${target}/${service_code}"

  $service_templates = [
      'conf/activemq.xml',
 ]

  tag($service_code)

  activemq::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
  }

  activemq::deploy { $deployment_code:
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => activemq::initialize[$deployment_code],
  }


  activemq::push_templates {
    $service_templates:
      directory => $deployment_code,
      target    => $carbon_home,
      require   => activemq::initialize[$deployment_code];
  }

  activemq::start { $deployment_code:
    owner   => $owner,
    target  => $carbon_home,
    require => [
      activemq::push_templates[$service_templates],
    ];
  }


}
