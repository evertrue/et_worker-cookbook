#
# Cookbook Name:: et_worker
# Recipe:: probymonitor
#
# Copyright (C) 2013 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

file '/usr/bin/probymonitor.sh' do
  action :delete
  only_if 'test -e /usr/bin/probymonitor.sh'
end

cron 'probymonitor' do
  action :delete
end
