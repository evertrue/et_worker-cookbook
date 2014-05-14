name             'et_worker'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_worker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.3.0'

depends 'postfix', '~> 3.0.4'
depends 'rds-s3-backups', '= 1.1.4'
depends 'berkshelf', '= 0.3.1'
depends 'stale-node-checker', '= 1.0.2'

provides 'worker'
