# Add the stable version of Nginx repository
exec { 'add nginx stable repo':
  command => 'sudo add-apt-repository ppa:nginx/stable',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# Update the list of software packages
exec { 'update packages':
  command => 'apt-get update',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# Install Nginx
package { 'nginx':
  ensure => 'installed',
}

# Allow HTTP traffic through UFW
exec { 'allow HTTP':
  command => "ufw allow 'Nginx HTTP'",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  onlyif  => '! dpkg -l nginx | egrep \'îi.*nginx\' > /dev/null 2>&1',
}

# Change folder permissions to 755 for /var/www
exec { 'chmod www folder':
  command => 'chmod -R 755 /var/www',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

# Create an index.html file with "Hello World!" content
file { '/var/www/html/index.html':
  content => "Hello World!\n",
}

# Create a 404.html file with custom content
file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page\n",
}

# Configure Nginx with custom settings including redirection and error page
file { 'Nginx default config file':
  ensure  => file,
  path    => '/etc/nginx/sites-enabled/default',
  content =>
    # Nginx server block configuration here
}

# Restart the Nginx service
exec { 'restart service':
  command => 'service nginx restart',
  path    => '/usr/bin:/usr/sbin:/bin',
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
