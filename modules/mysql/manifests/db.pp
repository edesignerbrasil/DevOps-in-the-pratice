define mysql::db($schema, $user = $title, $password) {
	
	Class['mysql::server'] -> Mysql::db[$title]

		exec { "$title-schema":
			unless => "mysql -u root $schema",
			command => "mysqladmin -u root create $schema",
			path => "/usr/bin/",
		}

		exec { "$title-user":
			unless => "mysql -u $user -p$password $schema",
			command => "mysql -u root -e \"GRANT ALL PRIVILEGES ON $schema.* TO '$user'@'%' IDENTIFIED BY '$password';\"",
			path => "/usr/bin/",
			require => Exec["$title-schema"],
		}
}