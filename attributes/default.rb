set['berkshelf']['api']['version'] = '1.1.1'

set['berkshelf']['api']['config_hash']['endpoints'] = {
  chef_server: {
    type: 'chef_server',
    options: {
      url: 'https://api.opscode.com/organizations/evertrue',
      client_name: 'berkshelf',
      client_key: '/etc/berkshelf/api-server/client.pem'
    }
  },
  opscode: {
    type: 'opscode',
    options: {
      url: 'http://cookbooks.opscode.com/api/v1'
    }
  },
  github: {
    type: 'github',
    options: {
      organization: 'evertrue'
    }
  }
}
