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

# Class lb::params
#
# This class manages lb parameters
#
# Parameters:
#
# Usage: Uncomment the variable and assign a value to override the wso2.pp value
#
#

class static_lb::params {

	$stratos_host_name	= 'stratos.integrateaz.gov'
	$cep_host_name		= 'cep.integrateaz.gov'
	$bam_host_name		= 'monitor.integrateaz.gov'
	$ues_host_name		= 'ues.integrateaz.gov'

	$stratos_ip		= '10.251.29.245'
	$cep_ip			= '10.251.29.124'
	$bam_ip			= '10.251.29.105'
	$ues_ip			= '10.251.29.23'
	
}
