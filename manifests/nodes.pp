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

# stratos components related nodes
# not supported in alpha version.
node 'autoscaler.wso2.com' inherits base {
  require java
  class {'autoscaler': maintenance_mode => 'norestart',}
}

node 'cc.wso2.com' inherits base {
  require java
  class {'cc': maintenance_mode   => 'norestart',}
}

node /cep/ inherits base {
  #require java
  class {'cep': maintenance_mode   => 'norestart',}
}


node 'mb.wso2.com' inherits base {
  require java
  class {'messagebroker': maintenance_mode   => 'norestart',}
}

node 'sc.wso2.com' inherits base {
  require java
  class {'manager': maintenance_mode   => 'norestart',}
}

# PHP-Nginx cartridge node
node /php-nginx/ inherits base {
  $docroot = '/opt/configs/'
  class {'agent':
	type 		   => 'az-nginx'
  }
  class {'php-nginx':
        syslog             => '/var/log',
        docroot            => '/var/www/html',
        samlalias          => undef

  }

 Class['php-nginx'] ~> Class['agent']

}

# private paas core
node /paas.core/ inherits base {
  class {'paascore': 
	config_db	=> 'xxxxx_sm_config',
  }
}

# activemq
node /activemq/ inherits base {
  class {'activemq':}
}

# hadoop
node /hadoop/ inherits base {
  class {'hadoops':}

}


# bam
node /bam/ inherits base {
  class {'bam':}
}

# ues
node /ues/ inherits base {
  class {'ues':}
}

# loadbalancer cartridge node
node /static.lb/ inherits base {
  class {'static_lb': maintenance_mode   => 'norestart'}

  Class['stratos_base'] -> Class['static_lb']
}

