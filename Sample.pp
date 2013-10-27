package {'httpd':
ensure => present,
}
package {'httpd-devel':
ensure => present,
require => Package ["httpd"]
}
package {'php':
ensure => present,
}
package {'php-devel':
ensure => present,
require => Package ["php"]
}
package {'php-pear':
ensure => present,
require => Package ["php"]
}
package {'php-mysql':
ensure => present,
require => Package ["php"]
}
package {'php-mbstring':
ensure => present,
require => Package ["php"]
}
package {'mysql':
ensure => present,
}
package {'mysql-server':
notify => Service ["mysqld"],
ensure => present,
require => Package ["mysql"]
}
package {'mysql-devel':
ensure => present,
require => Package ["mysql"]
}
file {'/etc/httpd/conf/httpd.conf':
notify => Service ["httpd"],
ensure => file,
mode => 0644,
source => '/root/payload/httpd.conf',
require => Package ["httpd"]
}
file {'/var/www/html/index.php':
notify => Service ["httpd"],
ensure => file,
mode => 0644,
source => '/root/payload/index.php',
require => Package ["httpd"]
}
file {'/var/www/html/phpMyAdmin':
ensure => directory,
recurse => true,
purge => true,
force => true,
mode => 0766,
source => '/root/payload/phpMyAdmin-4.0.8-all-languages',
require => Package ["httpd"],
}
file {'/etc/sysconfig/iptables':
notify => Service ["iptables"],
ensure => file,
mode => 0600,
source => '/root/payload/iptables',
}
service {'httpd':
ensure => running,
enable => true,
}
service {'iptables':
ensure => running,
enable => true,
}
service {'mysqld':
ensure => running,
enable => true,
}->
exec { "mysqladmin -u root password apple":
require => Package ["mysql-server"],
path => ["/usr/bin"],
}
