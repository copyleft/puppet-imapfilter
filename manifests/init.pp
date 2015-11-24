# Class to set up and run lots of imapfilter configs
class imapfilter (
  $directory = '/var/imapfilter',
  $system_user = 'imapfilter'
) {

  # Only tested on linux
  case $::kernel {
    'Linux': {
      package { 'imapfilter':
        ensure => 'latest';
      }

      user {
        $system_user:
          ensure     => present,
          managehome => true,
          shell      => '/bin/false',
          comment    => 'User to run imapfilters',
          home       => $directory;
      }

      file {
        "${directory}/":
          ensure  => 'directory',
          owner   => $system_user,
          purge   => true,
          recurse => true;
      }

    }

    default: {
      fail("${title}: Kernel '${::kernel}' is not currently supported")
    }
  }
}

