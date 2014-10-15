Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }

#package { "vim":
#  ensure => "installed"
#}

#package { "apache2":
#  ensure  => present,
#  require => Exec["apt-get update"],
#}

#service { "apache2":
#  ensure  => "running",
#  require => Package["apache2"],
#}

#file { "/var/www/sample-webapp":
#  ensure  => "link",
#  target  => "/vagrant/sample-webapp",
#  require => Package["apache2"],
#  notify  => Service["apache2"],
#}

include bootstrap
include tools
include known_hosts
include git
include apache
include php
include php::pear
include php::pecl
include mysql
include drupal::drush
include drupal
