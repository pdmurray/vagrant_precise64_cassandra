class java {

  exec { 'initial-update':
    command => 'sudo apt-get update',
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
  }

  package { "python-software-properties":
      ensure => installed 
  }

  exec { 'add-webupd8-key':
    command => 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886',
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
  }

  exec { 'apt-update':
    command => 'sudo apt-get update',
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
  }

  exec { "add-apt-repository-oracle":
    command => "sudo add-apt-repository -y ppa:webupd8team/java",
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
  }

  exec {
    'set-licence-selected':
    command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';

    'set-licence-seen':
    command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
  }

  package { 'oracle-java7-installer':
    ensure => installed
  }
  package { 'build-essential':
    ensure => installed
  }
  package { 'git':
    ensure => installed
  }
  package { 'ant':
    ensure => installed
  }
  package { 'python-pip':
    ensure => installed
  }

  exec { 'install-cass-prereq':
    command => 'sudo pip install cql PyYAML',
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
  }

  #file {'cassandra_setup.sh':
  #  name => '/home/vagrant/cassandra_setup.sh',
  #  ensure => present,
  #  owner => vagrant,
  #  group => vagrant,
  #  source => '/vagrant/files/cassandra_setup.sh',
  #}

  #exec { 'clone-cassandra':
  #  command => 'git clone https://github.com/pcmanus/ccm.git \
  #  ; sudo python /home/vagrant/ccm/setup.py install \
  #  ; sudo rm -rf /home/vagrant/ccm',
  #  path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/home/vagrant/ccm" ],
  #  logoutput => true,
  #}

  exec { 'build-cassandra':
    command => 'sudo bash /home/vagrant/cassandra_setup.sh',
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
    logoutput => true
  }


  Exec['initial-update'] -> Package['python-software-properties'] -> Exec['add-webupd8-key'] -> Exec['apt-update'] -> Exec['set-licence-selected'] -> Exec['set-licence-seen'] -> Package['oracle-java7-installer'] -> Package['build-essential'] -> Package['git'] -> Package['ant'] -> Package['python-pip'] -> Exec['install-cass-prereq'] -> Exec['build-cassandra'] 

}

include java

