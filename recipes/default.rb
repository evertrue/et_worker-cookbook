#
# Cookbook Name:: et_worker
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'rds-s3-backups'

node.set['postfix']['main']['mynetworks'] =
  node['ec2']['network_interfaces_macs'][node['macaddress'].downcase]['vpc_ipv4_cidr_block'] if node['ec2']

api_keys = Chef::EncryptedDataBagItem.load(
    'secrets',
    'api_keys'
  )[node.chef_environment]

if api_keys.nil?
  fail "Data bag secrets/api_keys is missing environment #{node.chef_environment}"
end

node.set['berkshelf_api']['config'] = {
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
      organization: 'evertrue',
      access_token: api_keys['github']['berkshelf']
    }
  }
}

include_recipe 'postfix::server'
include_recipe 'et_worker::probymonitor'
include_recipe 'stale-node-checker'
include_recipe 'berkshelf-api'

file node['berkshelf_api']['home'] + '/client.pem' do
  content api_keys['chef']['berkshelf']
  mode 0600
  owner 'root'
  group 'root'
  notifies :restart, 'runit_service[berks-api]'
end

runit_service 'berks-api' do
  action :start
end
