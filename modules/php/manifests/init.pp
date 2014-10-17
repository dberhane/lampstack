class php {

  # package install list
  $packages = [
    "php5",
    "php5-cli",
    "php5-mysql",
    "php-pear",
    "php5-dev",
    "php5-gd",
    "php5-mcrypt",
    "php5-memcache",
    "libapache2-mod-php5",
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }

# override and increase memory limit
file {'/etc/php5/conf.d/memory_limit.ini':
  ensure => present,
  owner => root, group => root, mode => 444,
  content => "memory_limit =  2046M",
  require =>  [Package['apache2']],
}

# override and increase maximum upload size
file {'/etc/php5/conf.d/upload_limits.ini':
  ensure => present,
  owner => root, group => root, mode => 444,
  content => "post_max_size = 10M \nupload_max_filesize = 10M \n",
  require =>  [Package['apache2']],
}

}