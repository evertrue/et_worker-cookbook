#
# Cookbook Name:: et_worker
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

node.set['postfix']['main']['mynetworks'] =
  node['ec2']['network_interfaces_macs'][node['macaddress'].downcase]['vpc_ipv4_cidr_block'] if node['ec2']

include_recipe 'postfix::server'
include_recipe 'stale-node-checker'
include_recipe 'ssh_known_hosts::cacher'

apt_repository 'brightbox-ruby' do
  uri 'http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu'
  distribution node['lsb']['codename']
  components %w(main)
  keyserver 'keyserver.ubuntu.com'
  key 'C3173AA6'
end

package 'ruby2.2'
# package 'ruby2.2-dev'

gem_package 'aws-cleanup'

cron_d 'awscleanup' do
  minute 20
  command '/usr/local/bin/aws-cleanup'
end
