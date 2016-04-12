name             'et_worker'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'All rights reserved'
description      'Installs/Configures et_worker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '4.0.0'

depends 'postfix', '~> 3.1'
depends 'stale-node-checker', '= 1.0.2'
depends 'route53', '= 0.4.0'
depends 'ssh_known_hosts'
depends 'apt'

provides 'worker'
