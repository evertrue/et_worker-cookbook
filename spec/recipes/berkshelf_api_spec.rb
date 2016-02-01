require 'spec_helper'

describe 'et_worker::berkshelf_api' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['berkshelf_api']['home'] = '/etc/berkshelf/api-server'
    end.converge(described_recipe)
  end

  before do
    mock_encrypted_data_bag_items
    stub_berkshelf_api_command
  end

  it 'includes berkshelf-api-server' do
    expect(chef_run).to include_recipe 'berkshelf-api-server'
  end

  it 'creates /etc/berkshelf/api-server/client.pem' do
    client_pem_resource = chef_run.file('/etc/berkshelf/api-server/client.pem')
    expect(chef_run).to create_file('/etc/berkshelf/api-server/client.pem').with(
      user: 'berkshelf',
      group: 'berkshelf',
      mode: 0600
    )
    expect(chef_run).to render_file('/etc/berkshelf/api-server/client.pem').with_content(
      "-----BEGIN RSA PRIVATE KEY-----\nDUMMY_KEY\n-----END RSA PRIVATE KEY-----\n"
    )
    expect(client_pem_resource).to notify('runit_service[berks-api]').to(:restart)
  end
end
