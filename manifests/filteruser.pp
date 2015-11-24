# Set up filter and cron job for a user
define imapfilter::filteruser(
  $imap_host,
  $imap_username,
  $imap_password,
  $imap_certificate_file = '', #TODO
  $ensure = 'present',
  $cron_hour = '*',
  $cron_minute = '*/3',
  $custom_template = 'imapfilter/imapfilter-basic.erb') {

  $filterpath = "${imapfilter::directory}/filter-${name}.conf"

  validate_re($ensure, [ '^present$', '^absent$' ],
    "${ensure} not supported for ensure. Allowed are 'present' and 'absent'.")

  file {
    "imapfilter-${name}": # User config file
      ensure  => $ensure,
      path    => $filterpath,
      owner   => $imapfilter::system_user,
      group   => 'root',
      mode    => '0600',
      content => template($custom_template);

#    "${imapfilter::directory}/certificates-${name}": # Certificate file
#      ensure  => $ensure,
#      path    => $filterpath,
#      owner   => $imapfilter::system_user,
#      group   => 'root',
#      mode    => '0600',
#      source  => $imap_certificate_file;
  }

  # User cron job
  cron {
    "Cron-for-${name}":
      ensure  => $ensure,
      command => sprintf(
        "MAILTO='%s' /usr/bin/imapfilter -c %s > /dev/null 2>/var/imapfilter/${name}.log",
        $imap_username,
        $filterpath),
      user    => $imapfilter::system_user,
      hour    => $cron_hour,
      minute  => $cron_minute;
  }
}

