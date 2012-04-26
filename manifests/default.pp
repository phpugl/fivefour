include apt

class phpugl {
  exec { 'apt-get update': command => '/usr/bin/apt-get update' }

  apt::ppa { "ppa:ondrej/php5": }
  apt::key { "ondrej": key        => "E5267A6C" }

  package { "git-core": ensure => present }
  package { "php5-fpm": ensure => present,    require => Apt::Ppa["ppa:ondrej/php5"] }
  package { "php5-cli": ensure => present,    require => Apt::Ppa["ppa:ondrej/php5"] }
  package { "nginx": ensure => present, require => Exec['apt-get update'] }

  file { "/etc/timezone": content => "Europe/Berlin" }
  file { "/etc/localtime": source => "/usr/share/zoneinfo/Europe/Berlin" }
  file { "/etc/ssh/sshd_config": source => "/vagrant/manifests/files/sshd_config" }

  service { "nginx": ensure => running, require => Package["nginx"] }

  file { "/etc/nginx/sites-enabled/default": ensure => absent, require => Package["nginx"] } 
  file { "/etc/nginx/sites-available/phpugl.local":
    ensure => link, 
    notify => Service["nginx"],
    require => Package["nginx"],
    target => "/vagrant/manifests/files/phpugl.local"
  }
  file { "/etc/nginx/sites-enabled/phpugl.local":
    ensure => link, 
    notify => Service["nginx"],
    require => Package["nginx"],
    target => "/etc/nginx/sites-available/phpugl.local"
  }

  group { "puppet": 
    ensure => "present",
  }
  
  user { "puppet":
		ensure => "present",
    gid => "puppet",
    require => Group["puppet"]
	}

}

include phpugl
