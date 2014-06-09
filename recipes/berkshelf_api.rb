#
# Cookbook Name:: et_worker
# Recipe:: berkshelf_api
#
# Copyright (C) 2014 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

api_keys = Chef::EncryptedDataBagItem.load(
    'secrets',
    'api_keys'
  )[node.chef_environment]

if api_keys.nil?
  fail "Data bag secrets/api_keys is missing environment #{node.chef_environment}"
end

node.set['berkshelf_api']['config'] = {
  home_path: node['berkshelf_api']['home'],
  endpoints: [
    {
      type: 'chef_server',
      options: {
        url: 'https://api.opscode.com/organizations/evertrue',
        client_name: 'berkshelf',
        client_key: '/etc/berkshelf/api-server/client.pem'
      }
    }
  ]
}

include_recipe 'berkshelf-api-server'

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
