group { 'puppet': ensure => present }
Exec { path => [ '/usr/local/bin', '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }
File { owner => 0, group => 0, mode => 0644 }

file { "/usr/local/bin/":
  ensure => "directory",
  owner => 0,
  group => 0,
  mode => 0755,
}

class {'apt':
  always_apt_update => true,
}

Class['::apt::update'] -> Package <|
    title != 'python-software-properties'
and title != 'software-properties-common'
|>

apt::key { '4F4EA0AAE5267A6C': }
apt::ppa { 'ppa:ondrej/php5-oldstable':
  require => Apt::Key['4F4EA0AAE5267A6C']
}

class { 'puphpet::dotfiles': }

package { [
    'build-essential',
    'libssl-dev',
    'libev-dev',
    'libpcre3',
    'libpcre3-dev',
    'git-core',
    'puppet',
    'vim',
    'curl',
  ]:
  ensure  => 'installed',
}

class { 'apache': }

apache::dotconf { 'custom':
  content => 'EnableSendfile Off',
}

apache::module { 'rewrite': }

apache::vhost { 'localhost':
  server_name   => 'localhost',
  serveraliases => [],
  docroot       => '/var/www/html',
  port          => '80',
  env_variables => [],
  priority      => '1',
}

class { 'php':
  service             => 'apache',
  service_autorestart => false,
  module_prefix       => '',
}

php::module { 'php5-cli': }
php::module { 'php5-curl': }
php::module { 'php5-intl': }
php::module { 'php5-mcrypt': }
php::module { 'php5-mysqlnd': }

class { 'php::devel':
  require => Class['php'],
}

class { 'php::pear':
  require => Class['php'],
}

php::pecl::module { 'APC':
  use_package => false
}
php::pecl::module { 'mongo':
  use_package => false
}
php::pecl::module { 'PDO':
  use_package => false
}
php::pecl::module { 'PDO_MYSQL':
  use_package => false
}

class { 'xdebug':
  service => 'apache',
}

class { 'composer':
  require => Package['php5', 'curl'],
}

puphpet::ini { 'mongo':
  value   => [
    'extension = mongo.so',
  ],
  ini     => '/etc/php5/conf.d/zzz_mongo.ini',
  notify  => Service['apache'],
  require => Class['php'],
}

puphpet::ini { 'xdebug':
  value   => [
    'xdebug.default_enable = 1',
    'xdebug.remote_autostart = 0',
    'xdebug.remote_connect_back = 1',
    'xdebug.remote_enable = 1',
    'xdebug.remote_handler = "dbgp"',
    'xdebug.remote_port = 9000',
  ],
  ini     => '/etc/php5/conf.d/zzz_xdebug.ini',
  notify  => Service['apache'],
  require => Class['php'],
}

puphpet::ini { 'custom':
  value   => [
    'date.timezone = "America/New_York"',
    'display_errors = On',
    'display_startup_errors = On',
    'error_reporting = -1',
    'short_open_tag = Off',
  ],
  ini     => '/etc/php5/conf.d/zzz_custom.ini',
  notify  => Service['apache'],
  require => Class['php'],
}
