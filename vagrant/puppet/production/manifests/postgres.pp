class postgres {

  firewall { '5432 - postgres server':
    dport => 5432,
  }

  class { 'postgresql::server':
    ip_mask_deny_postgres_user => '0.0.0.0/32',
    ip_mask_allow_all_users    => '0.0.0.0/0',
    listen_addresses           => '*',
    default_database           => 'postgres',
    package_ensure             => 'installed',
    postgres_password          => 'password',
  }

  postgresql::server::role { 'wallaby':
    connection_limit => -1,
    createdb         => true,
    createrole       => false,
    password_hash    => postgresql_password('wallaby', 'wallaby'),
  }

  postgresql::server::database {
    'walla_test':
      owner => 'wallaby';
    'walla_dev':
      owner => 'wallaby';
  }

}
