class ssh {
    package { "openssh-server":     ensure  => installed }

    file { "sshdconfig":
        name    => "/etc/ssh/sshd_config",
        content => template("sshd_config.erb"),
        owner   => "root",
    }

    ssh_authorized_key { "rootkey":
        ensure  => present,
        type    => ssh-rsa,
        key     => "AAAAB3NzaC1yc2EAAAABIwAAAQEAoyMiVDjNOJwiEbmGpJhBh98YdxCkqW0BwGGvBFYQvcaFUw+1/RisVWsJXr/WW2ywwDWT70wXvPLShpNGmbznWhlmJLk+V3XGwTr1Y8afYlNq8KJpHeygE3YulU8opA87VAsmTMjl58M006Nv/3mJ5dvzViZZ8bMfNrhbk8HFrxKdtgn+F4lDYoNW4LmzwzIUrqoxtwECIDh7nBXzWeYzr/7KpYrAEq7QYNu+4IYx3exD0LgCINUkSu/23wuTutsC+SmTgORs8EB00gj7+fud2OCRB16dq+5HK42d7Kt+gIoD3TAyzXA6Ji03R1kysIxKWtGfwblDjMwy5HiqVaze9Q==",
        name    => root@brianjhenderson.com,
        user    => root,
    }

    service { "ssh":
        require => Package[openssh-server],
        subscribe => File[sshdconfig],
        enable  => true,
        ensure  => running,
    }
}
