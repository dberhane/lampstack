class samba {

  # package install list
  $packages = [
    "samba",
    "samba-common",
  ]

  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }


  file{ '/etc/samba/smb.con' :
    ensure => present,
    source => 'puppet:///modules/samba/samba.sh',
    require =>  [Package['samba']],
  }

  service { "smbd":
    ensure => running,
    require => [Package["samba"]],
    enable => true,
    restart => 'service smbd restart',
  }

  service { "nmbd":
    ensure => running,
    require => [Package["samba"]],
    enable => true,
    restart => 'service nmbd restart',
  }

}