api_key = Chef::EncryptedDataBagItem.load(
    node["probymonitor"]["api_key_databag"],
    node["probymonitor"]["api_key_databag_item"]
  )["probymonitor"]

template "/usr/bin/probymonitor.sh" do
  source "probymonitor.sh.erb"
  owner "root"
  group "root"
  mode 00755
  variables(
      :api_key => api_key,
      :proby_task_id => node["probymonitor"]["task_id"]
    )
end

cron "probymonitor" do
  hour "*"
  minute "*"
  day "*"
  month "*"
  weekday "*"
  user 'nobody'
  shell '/bin/bash'
  command "/usr/bin/probymonitor.sh"
end
