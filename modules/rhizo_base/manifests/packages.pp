# Class: rhizo_base::packages
#
# This module manages the packages not included in other modules
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class rhizo_base::packages {
  
  exec { "apt-update":
      command => "/usr/bin/apt-get update"
  }
  Exec["apt-update"] -> Package <| |>
  
  package { ['mosh', 'git', 'openvpn', 'lm-sensors', 'runit', 'daemontools', 'sqlite3',
            'libffi-dev']:
      ensure  => installed,
      require => Class['rhizo_base::apt'],
    }

  package { ['puppet', 'puppet-common']:
      ensure  => installed,
      require => Class['rhizo_base::puppetlabs'],
    }

  }
