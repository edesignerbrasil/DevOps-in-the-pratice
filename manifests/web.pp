include mysql::client


file { $keystore_file:
	mode 	=> 0644,
	source	=>	"/vagrant/manifests/.keystore",
}

class { "tomcat::server":
	connectors		=>	[$ssl_connector],
	data_sources	=>	{
		"jdbc/web"	=>	$db,
		"jdbc/secure"	=>	$db,
		"jdbc/storage"	=>	$db,
	}, 
	require		=>	File[$keystore_file],
	}

file { "/var/lib/tomcat7/webapps/devopsnapratica.war":
	owner => tomcat7,
	group => tomcat7,
	mode => 0644,
	source => "/vagrant/manifests/devopsnapratica.war",
	require => Package["tomcat7"],
	notify => Service["tomcat7"],
}