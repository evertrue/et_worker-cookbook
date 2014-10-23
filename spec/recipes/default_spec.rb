require 'spec_helper'

describe 'et_worker::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set['berkshelf_api']['home'] = '/etc/berkshelf/api-server'
    end.converge(described_recipe)
  end

  before do
    mock_encrypted_data_bag_items
    stub_berkshelf_api_command
  end

  %w(
    rds-s3-backups
    postfix::server
    et_worker::probymonitor
    stale-node-checker
    et_worker::berkshelf_api
  ).each do |recipe|
    it "includes #{recipe}" do
      expect(chef_run).to include_recipe recipe
    end
  end
end
