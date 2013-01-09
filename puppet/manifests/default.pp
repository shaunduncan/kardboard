# Set global package provider
Package { provider => 'aptitude' }
import "logrotate"
include git
include devtools
include pythondev
include redis
include memcache

include mongodb
mongodb::setup { "kardboard": }
logrotate::rule { 'mongodb':
  path         => '/var/log/mongodb/*.log',
  rotate       => 1,
  rotate_every => 'day',
  postrotate   => 'killall -SIGUSR1 mongod',
}


import "kardboard"
class { 'kardboard':
# TODO
#    get runserver working
#    get celery working
#    integrate mongo backup script
#    get supervisor installed
    kbuser => 'vagrant',
    src => '/vagrant',
    conf => '/vagrant/kardboard-local.cfg',
    server => 'gunicorn',
}


# TODO
# option for runserver
# logrotate for kardboard
# celery for kardboard
# nginx SSL
# Docs on creating kardboard-local.conf and spinning up vagrant
