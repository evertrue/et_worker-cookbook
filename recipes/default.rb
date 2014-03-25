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
  fail "Data bag secrets/api_keys is missing environment " \
    "#{node.chef_environment}"
end

directory node['berkshelf']['api']['home'] do
  owner     'root'
  group     'root'
  mode      0755
  action    :create
  recursive true
end

file node['berkshelf']['api']['home'] + '/client.pem' do
  content api_keys['chef']['berkshelf']
  mode 0600
  owner 'root'
  group 'root'
  notifies :restart, 'runit_service[berks-api]'
end

# The following silliness is required because the Berkshelf API wants an array
# of hashes, and Chef isn't good at modifying those.

# Chef::Log.info("Endpoints Hash: #{node['berkshelf']['api']['config']['endpoints_hash'].inspect}")

node.set['berkshelf']['api']['config_hash']['endpoints']['github']['options']['access_token'] =
  api_keys['github']['berkshelf']

# Chef::Log.info("Endpoints Hash: #{node['berkshelf']['api']['config']['endpoints_hash'].inspect}")

endpoints = node['berkshelf']['api']['config_hash']['endpoints'].map do |k, v|
  v
end

# Chef::Log.info("Endpoints: #{endpoints}")

node.set['berkshelf']['api']['config']['endpoints'] = endpoints

include_recipe 'postfix::server'
include_recipe 'et_worker::probymonitor'
include_recipe 'stale-node-checker'
include_recipe 'berkshelf::api_server'
include_recipe 'berkshelf::api_proxy'

runit_service 'berks-api' do
  action :start
end
