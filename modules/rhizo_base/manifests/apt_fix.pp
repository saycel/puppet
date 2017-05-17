class rhizo_base::apt_fix{
exec {'clear-apt-lists':
  command => "/bin/rm -rf /var/lib/apt/lists/*"
}

exec {'apt-update':
  command => "/usr/bin/apt-get update"
}

exec {'nodesource-apt-fix':
  command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280"
}

}
