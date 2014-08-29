# -*- mode: ruby -*-
# vi: set ft=ruby :
 
class known_hosts( $username = 'vagrant' ) {
    $group = $username
    $server_list = [ 'github.com' ]
 
    file{ '/home/vagrant/.ssh' :
      ensure => directory,
      group => $group,
      owner => $username,
      mode => 0600,
    }
 
    file{ '/home/vagrant/.ssh/known_hosts' :
      ensure => file,
      group => $group,
      owner => $username,
      mode => 0600,
      require => File[ '/home/vagrant/.ssh' ],
    }
 
    file{ '/tmp/known_hosts.sh' :
      ensure => present,
      source => 'puppet:///modules/known_hosts/known_hosts.sh',
    }
 
   exec{ 'add_known_hosts' :
     command => "/tmp/known_hosts.sh",
     path => "/sbin:/usr/bin:/usr/local/bin/:/bin/",
     provider => shell,
     user => 'vagrant',
     require => File[ '/home/vagrant/.ssh/known_hosts', '/tmp/known_hosts.sh' ]
    }
}