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
# Executes the deployment by pushing all necessary configurations and patches

define agent::deploy ($security, $target, $owner, $group) {
  file { "/tmp/${agent::deployment_code}":
    ensure       => present,
    owner        => $owner,
    group        => $group,
    sourceselect => all,
    ignore       => '.svn',
    recurse      => true,
    source       => [
      'puppet:///modules/agent/configs/',
      'puppet:///modules/agent/patches/']
  }

  exec {
    "Copy_${name}_modules_to_carbon_home":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      command => "cp -r /tmp/${agent::deployment_code}/* ${target}/; chown -R ${owner}:${owner} ${target}/; chmod -R 755 ${target}/",
      require => File["/tmp/${agent::deployment_code}"];

    "Remove_${name}_temporory_modules_directory":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      command => "rm -rf /tmp/${agent::deployment_code}",
      require => Exec["Copy_${name}_modules_to_carbon_home"];
	
    "Remove old httpclient and httpcore jars":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      command => "rm -rf ${target}/lib/httpclient-4.1.1-wso2v1.jar; rm -rf ${target}/lib/httpcore-4.1.0-wso2v1.jar",
      require => Exec["Copy_${name}_modules_to_carbon_home"];

  }
}
