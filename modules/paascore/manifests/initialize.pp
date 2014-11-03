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
# Initializing the deployment

define paascore::initialize ($repo, $version, $service, $local_dir, $target, $mode, $owner, $stratos_pack, $installation, $mysql_jar) {

  exec {
    "creating_installation_directory_${installation}":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', 
      command => "mkdir -p ${installation}";
 
    "creating_${target}_for_${name}":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command => "mkdir -p ${target}";

    "creating_local_package_repo_for_${name}":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/bin/',
      unless  => "test -d ${local_dir}",
      command => "mkdir -p ${local_dir}";
  }

  file {
    "/${local_dir}/${service}.zip":
      ensure => present,
      source => ["puppet:///packs/${service}.zip"],
      require   => Exec["creating_local_package_repo_for_${name}", "creating_${target}_for_${name}"];

    "/${local_dir}/${stratos_pack}.zip":
      ensure => present,
      source => ["puppet:///packs/${stratos_pack}.zip"],
      require   => Exec["creating_local_package_repo_for_${name}", "creating_${target}_for_${name}"];

    "/${local_dir}/${mysql_jar}":
      ensure => present,
      source => ["puppet:///packs/${mysql_jar}"],
      require   => Exec["creating_local_package_repo_for_${name}", "creating_${target}_for_${name}"];

  }

  exec {
    "extracting_/${local_dir}/${service}.zip":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $target,
      unless    => "test -d ${target}/${service}/stratos-installer",
      command   => "unzip /${local_dir}/${service}.zip",
      logoutput => 'on_failure',
      creates   => "${target}/${service}/stratos-installer",
      timeout   => 0,
      require   => File["/${local_dir}/${service}.zip", "/${local_dir}/${stratos_pack}.zip", "/${local_dir}/${mysql_jar}"];

    "setting_permission_for_${name}":
      path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      cwd       => $target,
      command   => "chown -R ${owner}:${owner} ${target}/${service} ;
                    chmod -R 755 ${target}/${service}",
      logoutput => 'on_failure',
      timeout   => 0,
      require   => Exec["extracting_/${local_dir}/${service}.zip"];

   "creating_bin_directory":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command => "mkdir -p ${target}/${service}/stratos-installer/config/all/bin/",
      require => Exec["setting_permission_for_${name}"];

   "creating_tomcat_directory":
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      command => "mkdir -p ${target}/${service}/stratos-installer/config/all/repository/conf/tomcat",
      require => Exec["setting_permission_for_${name}"];

  }
}
