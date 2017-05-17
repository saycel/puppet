class rhizo_base::puppetlabs{
#exec {'clear-apt-lists':
#  command => "/bin/rm -rf /var/lib/apt/lists/*"
#}

#exec {'apt-update':
#  command => "/usr/bin/apt-get update"
#}

file{'/tmp/puppetlabs':
  ensure => directory,
}
package {'wget':
  provider => apt,
  ensure => latest,
}

exec{'retrieve_puppetlabs':
  command => "/usr/bin/wget -q https://apt.puppetlabs.com/puppetlabs-release-precise.deb -O /tmp/puppetlabs/puppetlabs-release-precise.deb",
  creates => "/tmp/puppetlabs/puppetlabs-release-precise.deb",
  require => [
    File['/tmp/puppetlabs'],
    Package['wget'],
  ],
}

file{'/tmp/puppetlabs/puppetlabs-release-precise.deb':
  owner => root,
  group => root,
  require => Exec['retrieve_puppetlabs'],
}

package{'3.8.1-1puppetlabs1':
  provider => dpkg,
  ensure => installed,
  source => "/tmp/puppetlabs/puppetlabs-release-precise.deb"
}

#exec{'puppetlabs':
#  command => "/usr/bin/dpkg -i /tmp/puppetlabs/puppetlabs-release-precise.deb"
#}



}
