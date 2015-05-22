name             'et_worker'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_worker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.0.2'

depends 'postfix', '~> 3.1'
depends 'rds-s3-backups', '~> 1.2'
depends 'stale-node-checker', '= 1.0.2'
depends 'berkshelf-api-server', '= 2.1.0'
depends 'route53', '= 0.4.0'
depends 'ssh_known_hosts'

provides 'worker'
