class ssh {
    package { "openssh-server":     ensure  => installed }

    file { "sshdconfig":
        name    => "/etc/ssh/sshd_config",
        content => template("ssh/sshd_config.erb"),
        owner   => "root",
    }

#    ssh_authorized_key { "rootkey":
#        ensure  => present,
#        type    => ssh-rsa,
#        key     => file("/etc/puppet/files/authorized_keys/rootkey"),
#        name    => "root@brianjhenderson.com",
#        user    => root,
#    }

    service { "ssh":
        require => Package[openssh-server],
        subscribe => File[sshdconfig],
        enable  => true,
        ensure  => running,
    }
}
