set['berkshelf_api']['version'] = '1.1.1'

set['berkshelf_api']['config'] = {
  home_path: node['berkshelf_api']['home'],
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
