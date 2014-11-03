# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# Class: static_lb
#
# This class installs Stratos Load balancer
#
#
# Actions:
#   - Install Stratos Load balancer
#
# Requires:
#
# Sample Usage:
#

class static_lb (
  $version            = '4.0.0-wso2v1',
  $offset             = 0,
  $tribes_port        = 4000,
  $maintenance_mode   = true,
  $members            = {},
  $owner              = 'root',
  $group              = 'root',
  $target             = "/mnt/${server_ip}",
) inherits params {


  $deployment_code = 'static_lb'
  $carbon_version  = $version
  $service_code    = 'load-balancer'
  $carbon_home     = "${target}/apache-stratos-${service_code}-${carbon_version}"

  $service_templates = [
    'conf/axis2/axis2.xml',
    'conf/loadbalancer.conf',
    'conf/jndi.properties',
    ]

  tag($service_code)

  static_lb::clean { $deployment_code:
    mode   => $maintenance_mode,
    target => $carbon_home,
  }

  static_lb::initialize { $deployment_code:
    repo      => $package_repo,
    version   => $carbon_version,
    service   => $service_code,
    local_dir => $local_package_dir,
    target    => $target,
    mode      => $maintenance_mode,
    owner     => $owner,
    require   => static_lb::clean[$deployment_code],
  }

  static_lb::deploy { $deployment_code:
    service  => $deployment_code,
    security => true,
    owner    => $owner,
    group    => $group,
    target   => $carbon_home,
    require  => static_lb::initialize[$deployment_code],
  }

  static_lb::push_templates {
    $service_templates:
      target    => $carbon_home,
      directory => $deployment_code,
      require   => static_lb::deploy[$deployment_code];
  }

  static_lb::start { $deployment_code:
    owner   => $owner,
    target  => $carbon_home,
    require => [
      static_lb::initialize[$deployment_code],
      static_lb::deploy[$deployment_code],
      static_lb::push_templates[$service_templates],
      ],
  }
}
