name             'et_worker'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_worker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.2'

depends 'postfix', '~> 3.0.4'
depends 'rds-s3-backups', '~> 1.2'
depends 'stale-node-checker', '= 1.0.2'
depends 'berkshelf-api-server', '= 1.4.0'
depends 'route53', '= 0.3.6'
depends 'ssh_known_hosts'

provides 'worker'
