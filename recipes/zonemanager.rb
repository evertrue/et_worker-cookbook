if node['platform_family'] == 'debian'
  execute 'apt-get update' do
    command 'apt-get update'
    action  :nothing
  end.run_action(:run)
end

include_recipe 'route53'

data_bag_data = data_bag_item('dns', 'zones')
creds = Chef::EncryptedDataBagItem.load(
  'secrets',
  'aws_credentials'
)[node['route53']['aws_user']]

node['route53']['zones'].each do |zone|
  z_data = EtWorker::ZoneManager.new(data_bag_data[zone], creds)

  z_data.updated.each_with_index do |record, i|
    route53_record "#{zone}_#{i}_#{record['name']}_#{record['type']}_create" do
      name                  record['name']
      value                 record['value']
      type                  record['type']
      ttl                   record['ttl'].to_i
      zone_id               data_bag_data[zone]['id']
      aws_access_key_id     creds['access_key_id']
      aws_secret_access_key creds['secret_access_key']
    end
  end

  z_data.removed.each_with_index do |record, i|
    route53_record "#{zone}_#{i}_#{record['name']}_#{record['type']}_delete" do
      name                  record['name']
      type                  record['type']
      zone_id               data_bag_data[zone]['id']
      aws_access_key_id     creds['access_key_id']
      aws_secret_access_key creds['secret_access_key']
      action               :delete
    end
  end
end
