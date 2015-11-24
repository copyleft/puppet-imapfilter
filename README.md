# imapfilter

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with [Modulename]](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)


## Overview

## Usage

```

node 'fqdn' {
  class {
    'imapfilter':;
  }

  imapfilter::filteruser {
    'user':
      imap_host     => 'imap.example.com',
      imap_username => 'user@host.no',
      imap_password => 'password';
  }

}

```

## TODO

* Encrypt or hide passwords
* Enable certificates and keep them somewhere
* Introduce a minute or two of jitter to cron jobs
* Common error log or error mail to automatic?
* Move templates away if this is to be published.

## Limitations

Tested on Ubuntu with Puppet 2.6

## Development

git@gitlab01.copyleft.no:operations/puppet-imapfilter.git

## Release notes

1.0 initial release
