exec { "apt-update":
	command => "/usr/bin/apt-get update"
}

package { "mysql-server":
	ensure => installed,
	require => Exec["apt-update"],
}

file { "/etc/mysql/conf.d/allow_external.cnf":
	owner => mysql,
	group => mysql,
	mode => 0644,
	content => template("/vagrant/mainfests/allow_ext.cnf"),
	require => Package["mysql-server"],
}