class mysql-server {

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
	notify => Service["mysql"],
}

service { "mysql":
	ensure => running,
	enable => true,
	hasstatus => true,
	hasrestart => true,
	require => Package["mysql-server"],
}

exec { "remove-anonymous-user":
	command => "mysql -u root -e \"DELETE FROM mysql.user WHERE user=’’; FLUSH PRIVILEGES\"",
	onlyif => "mysql -u’ ’",
	path => "/usr/bin",
	require => Service["mysql"],
}


}

include mysql-server

exec { "loja-schema":
	unless => "mysql -u root loja_schema",
	command => "mysqladmin -uroot create loja_schema",
	path => "/usr/bin/",
	require => Service["mysql"],
}


exec { "loja-user":
	unless => "mysql -u loja -p lojasecret loja_schema",
	command => "mysql -uroot -e \"GRANT ALL PRIVILEGES ON loja_schema.* TO 'loja'@'%'' IDENTIFIED BY 'lojasecret';\"",
	path => "/usr/bin/",
	require => Exec["loja-schema"],
}