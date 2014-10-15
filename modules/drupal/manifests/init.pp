class drupal {

	# a fuller example, including permissions and ownership
	file { ["/opt/sites", "/opt/sites/drupal"]:
    	ensure => "directory",
    	owner  => "vagrant",
    	group  => "vagrant",
    	mode   => 755,
    	recurse => true,
	}

	# HW The BMJ site root folder
	file { "/opt/sites/hw":
    	ensure => "directory",
    	owner  => "vagrant",
    	group  => "vagrant",
    	mode   => 755,
    	recurse => true,
	}

# Include Drupal index.php
file{ '/opt/sites/hw/index.php' :
  ensure => present,
  owner  => "vagrant",
  group  => "vagrant",
  source => 'puppet:///modules/drupal/index.php',
}

# BMJ and HW modules, themes symlinks syntax
file { '/opt/sites/hw/drupal-webroot/sites/default/scripts':
   ensure => 'link',
   target => '/opt/sites/hw/drupal-site-jnl-bmj/scripts',
}

file { "/opt/sites/hw/files":
    ensure => "directory",
    owner  => "vagrant",
    group  => "vagrant",
    mode   => 777,    
}

file { '/opt/sites/hw/drupal-webroot/sites/default/files':
   ensure => 'link',
   target => '/opt/sites/hw/files',
}

file { '/opt/sites/hw/drupal-webroot/sites/default/libraries':
   ensure => 'link',
   target => '/opt/sites/hw/drupal-site-jnl-bmj/libraries',
}

file { '/opt/sites/hw/drupal-webroot/sites/default/modules':
   ensure => 'link',
   target => '/opt/sites/hw/drupal-site-jnl-bmj/modules',
}

file { '/opt/sites/hw/drupal-webroot/sites/default/themes':
   ensure => 'link',
   target => '/opt/sites/hw/drupal-site-jnl-bmj/themes',
}

file { '/opt/sites/hw/drupal-webroot/sites/default/settings.php':
   ensure => 'link',
   target => '/opt/sites/hw/settings.php',
}

   exec { "create-drupal-db":
      unless => "/usr/bin/mysql -uroot -proot drupal",
      command => "/usr/bin/mysql -uroot -proot -e \"create database drupal; grant all on drupal.* to root@localhost identified by 'root';\"",
      require => Service["mysql"],
    }

  exec { "install-drupal":
    cwd => "/opt/sites/drupal",
    command => "/usr/local/bin/drush -y dl drupal-7.31 --destination='/opt/sites' --drupal-project-rename='drupal' && /usr/local/bin/drush site-install -r '/opt/sites/drupal' standard --account-name=admin --account-pass='19bmjpg' --db-url='mysql://root:root@localhost/drupal'",
    require => [File["/opt/sites/drupal"], Class["drupal::drush"], Exec["create-drupal-db"]],
  }

vcsrepo { "/opt/sites/hw/drupal-highwire":
  ensure   => latest,
  owner => vagrant,
  user => root,
  group => vagrant,
  provider => git,
  require =>  [Package['git'], File['/opt/sites/hw']],
  source => "git@github.com:highwire/drupal-highwire.git",
  revision => '7.x-1.x-stable',
}

vcsrepo { "/opt/sites/hw/drupal-webroot":
  ensure   => latest,
  owner => vagrant,
  user => root,
  group => vagrant,
  provider => git,
  require =>  [Package['git'], File['/opt/sites/hw']],
  source => "git@github.com:highwire/drupal-webroot.git",
  revision => '7.x-1.x-stable',
}


vcsrepo { "/opt/sites/hw/drupal-site-jnl-bmj":
  ensure   => latest,
  owner => vagrant,
  user => root,
  group => vagrant,
  provider => git,
  require =>  [Package['git'], File['/opt/sites/hw']],
  source => "git@github.com:highwire/drupal-site-jnl-bmj.git",
  revision => '7.x-1.x-dev',
}


}



