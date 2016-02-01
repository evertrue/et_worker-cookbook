#
# Cookbook Name:: et_worker
# Recipe:: probymonitor
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

template '/usr/bin/probymonitor.sh' do
  action :delete
end

cron 'probymonitor' do
  action :delete
end
