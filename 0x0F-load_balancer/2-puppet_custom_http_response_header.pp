# Update package information and install Nginx package
package { 'nginx':
  ensure => installed,
  require => Exec['apt-update'],
}

# Update package information
exec { 'apt-update':
  command => '/usr/bin/apt-get -y update',
  path    => ['/usr/bin', '/bin'],
  refreshonly => true,
}

# Create a basic HTML file
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
}

# Configure Nginx to add the custom HTTP header
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => template('nginx/custom_header.erb'),
  notify  => Service['nginx'],
}

# Ensure Nginx is running and enable it at boot
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
