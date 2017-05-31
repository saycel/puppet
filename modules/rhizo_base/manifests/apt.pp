# Class: rhizo_base::apt
#
# This module manages the apt repositories
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class rhizo_base::apt {
  class { '::apt': }
  apt::ppa { 'ppa:keithw/mosh': }
  apt::ppa { 'ppa:ondrej/php': }
  apt::ppa { 'ppa:ondrej/apache2': }
  apt::ppa { 'ppa:formorer/icinga': }
  file { '/etc/apt/apt.conf.d/90unsigned':
      ensure  => present,
      content => 'APT::Get::AllowUnauthenticated "true";',
    }
  apt::source { 'rhizomatica':
      location          => 'http://dev.rhizomatica.org/ubuntu/',
      release           => 'precise',
      repos             => 'main',
      include_src       => false,
      require           => File['/etc/apt/apt.conf.d/90unsigned'],
    }

  apt::source { 'nodesource':
      location    => 'https://deb.nodesource.com/node_0.10',
      release     => 'precise',
      repos       => 'main',
      key_source  => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key'
    }
   exec {'nodesource-apt-fix':
     command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280"
    }  
}
