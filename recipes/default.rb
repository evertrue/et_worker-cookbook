#
# Cookbook Name:: et_worker
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rds-s3-backups"

node.set['postfix']['mail_relay_networks'] = node["ec2"]["network_interfaces_macs"][node["macaddress"].downcase]['vpc_ipv4_cidr_block'] if node["ec2"]

include_recipe "postfix::server"
