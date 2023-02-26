$packages = [ 'httpd', 'php', 'php-mysqlnd']

#install packages
package { $packages: }

#vhost files
file { '/etc/httpd/conf.d/vhost-app2.conf': 
    ensure => present,
    source => "/vagrant/config/vhost-app2.conf",
}

file { '/etc/httpd/conf.d/vhost-app4.conf': 
    ensure => present,
    source => "/vagrant/config/vhost-app4.conf",
}

#create directory
file { '/var/www/app2':
    ensure => 'directory',
}

file { '/var/www/app4':
    ensure => 'directory',
}

#app files rooting
file { '/var/www/app4/index.php': 
    ensure => present,
    source => "/vagrant/apps/app4/web/index.php",
}

file { '/var/www/app4/config.php': 
    ensure => present,
    source => "/vagrant/apps/app4/web/config.php",
}

file { '/var/www/app4/chef-logo.png': 
    ensure => present,
    source => "/vagrant/apps/app4/web/images/chef-logo.png",
}

file { '/var/www/app4/docker-logo.png': 
    ensure => present,
    source => "/vagrant/apps/app4/web/images/docker-logo.png",
}

file { '/var/www/app4/elastic-stack-logo.png': 
    ensure => present,
    source => "/vagrant/apps/app4/web/images/elastic-stack-logo.png",
}

file { '/var/www/app4/puppet-logo.png': 
    ensure => present,
    source => "/vagrant/apps/app4/web/images/puppet-logo.png",
}

file { '/var/www/app4/salt-stack-logo.png': 
    ensure => present,
    source => "/vagrant/apps/app4/web/images/salt-stack-logo.png",
}

file { '/var/www/app4/terraform-logo.png': 
    ensure => present,
    source => "/vagrant/apps/app4/web/images/terraform-logo.png",
}

file { '/var/www/app2/index.php': 
    ensure => present,
    source => "/vagrant/apps/app2/web/index.php",
}

file { '/var/www/app2/config.php': 
    ensure => present,
    source => "/vagrant/apps/app2/web/config.php",
}

file { '/var/www/app2/bulgaria-map.png': 
    ensure => present,
    source => "/vagrant/apps/app2/web/bulgaria-map.png",
}

#firewall config
class { 'firewall':}

firewall { '000 accept 8001/tcp': 
    action => 'accept',
    dport => 8001,
    proto => 'tcp',
}

firewall { '000 accept 8002/tcp': 
    action => 'accept',
    dport => 8002,
    proto => 'tcp',
}

#selinux to connect machines
class { selinux : 
    mode => 'permissive',
}

file_line { 'hosts-web':
    ensure => present,
    path => '/etc/hosts',
    line => '192.168.99.101 web.do2.lab web',
    match => '^192.168.99.101',  
}

file_line { 'hosts-db':
    ensure => present,
    path => '/etc/hosts',
    line => '192.168.99.102 db.do2.lab db',
    match => '^192.168.99.102',
}

#start php
service { httpd:
    ensure => running,
    enable => true,
}
