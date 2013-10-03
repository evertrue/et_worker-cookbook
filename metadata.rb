name             'et_worker'
maintainer       'EverTrue, Inc.'
maintainer_email 'eric.herot@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_worker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.0'

depends 'rds-s3-backups', '= 1.1.0'
depends 'postfix', '~> 3.0.0'

provides 'worker'
