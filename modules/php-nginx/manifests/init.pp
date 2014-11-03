class php-nginx ($syslog="", $docroot="/var/www/html", $samlalias="") {
  $packages = [
    'nginx',
    'gcc',
    'gcc-c++',
    'libxml2-devel',
    'openssl-devel',
    'mailcap',
    'make',
    'screen',
    'libstdc++-devel',
    'openssl.x86_64',
    'mod_ssl.x86_64',
    'php',
    'php-fpm',
    'php-adodb.noarch',
    'php-dba.x86_64',
    'php-gd.x86_64',
    'php-imap.x86_64',
    'php-ldap.x86_64',
    'php-mcrypt.x86_64',
    'php-mysql.x86_64',
    'php-pear.noarch',
    'php-xml.x86_64',
    'php-xmlrpc.x86_64',
    'php.x86_64',
    'php-pecl-apc',
    'php-pecl-memcache.x86_64',
    'git-all.noarch',
    ]

#  file { '/etc/apt/apt.conf.d/90forceyes':
#    ensure => present,
#    source => 'puppet:///modules/php/90forceyes';
#  }

#  exec { 'update-apt':
#    path    => ['/bin', '/usr/bin'],
#    command => 'apt-get update > /dev/null 2>&1 &',
#    require => File['/etc/apt/apt.conf.d/90forceyes'],
#  }

  package { $packages:
    ensure   => installed,
  }

  # Apache
  file {
    '/etc/nginx/conf.d/default.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0775',
      notify  => Service['nginx'],
      content => template('php-nginx/nginx/nginx.conf.erb'),
      require => Package['nginx'];
#
#    '/etc/apache2/sites-available/default':
#      owner   => 'root',
#      group   => 'root',
#      mode    => '0775',
#      notify  => Service['apache2'],
#      content => template('php/apache2/sites-available/default.erb'),
#      require => Package['apache2'];
#
#    '/etc/apache2/sites-available/default-ssl':
#      owner   => 'root',
#      group   => 'root',
#      mode    => '0775',
#      notify  => Service['apache2'],
#      content => template('php/apache2/sites-available/default-ssl.erb'),
#      require => Package['apache2'];
  }

#  exec {
#    'enable ssl module':
#      path    => ['/bin', '/usr/bin', '/usr/sbin/'],
#      command => 'a2enmod ssl',
#      require => Package['apache2'];
#  }

  service { 'nginx':
    ensure    => running,
    name      => 'nginx',
    hasstatus => true,
    pattern   => 'nginx',
    require   => Package['nginx'];
  }

  service { 'php-fpm':
    ensure    => running,
    name      => 'php-fpm',
    hasstatus => true,
    pattern   => 'php-fpm',
    require   => Package['php-fpm'];
  }

  exec { 'remove www contents':
    path    => '/bin/',
    command => "rm -rf /var/www/html/*",
    require => Package['nginx'],
  }

  # Apache end
#  exec { 'clone git repo': 
#    path     => ['/bin', '/usr/bin', '/usr/sbin/'],
#    cwd      => '/var/www',
#    command  => "git clone ${stratos_instance_data_git_repo}",
#    require  => [
#      Package['git-all.noarch'],
#      Package['httpd'],
#    ]
#  }
}
