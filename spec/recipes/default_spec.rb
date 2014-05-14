require 'spec_helper'

describe 'et_worker::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['berkshelf_api']['home'] = '/etc/berkshelf/api-server'
    end.converge(described_recipe)
  end

  before do
    Chef::EncryptedDataBagItem.stub(:load).with('secrets', 'database_credentials').and_return(
      '_default' => {
        'admin' => {
          'username' => '@@TESTING_USER@@',
          'password' => '@@TESTING_PASS@@'
        }
      }
    )

    Chef::EncryptedDataBagItem.stub(:load).with('secrets', 'aws_credentials').and_return(
      'etworkerbackup' => {
        'access_key_id' => 'SAMPLE_ACCESS_KEY_ID',
        'secret_access_key' => 'SECRET_ACCESS_KEY'
      }
    )

    Chef::EncryptedDataBagItem.stub(:load).with('secrets', 'api_keys').and_return(
      '_default' => {
        'chef' => {
          'berkshelf' => "-----BEGIN RSA PRIVATE KEY-----\nDUMMY_KEY\n-----END RSA PRIVATE KEY-----\n"
        }
      }
    )

    # Stubbing a command that's executed in the Berkshelf API cookbook
    stub_command(
      'cd /opt/berkshelf-api/v1.3.1 && /opt/chef/embedded/bin/bundle check'
    ).and_return(
      'The Gemfile\'s dependencies are satisfied'
    )
  end

  %w(
    rds-s3-backups
    postfix::server
    et_worker::probymonitor
    stale-node-checker
    berkshelf-api
  ).each do |recipe|
    it "includes #{recipe}" do
      expect(chef_run).to include_recipe recipe
    end
  end

  it 'creates /etc/berkshelf/api-server/client.pem' do
    client_pem_resource = chef_run.file('/etc/berkshelf/api-server/client.pem')
    expect(chef_run).to create_file('/etc/berkshelf/api-server/client.pem').with(
      user: 'root',
      group: 'root',
      mode: 0600
    )
    expect(chef_run).to render_file('/etc/berkshelf/api-server/client.pem').with_content(
      "-----BEGIN RSA PRIVATE KEY-----\nDUMMY_KEY\n-----END RSA PRIVATE KEY-----\n"
    )
    expect(client_pem_resource).to notify('runit_service[berks-api]').to(:restart)
  end
end
