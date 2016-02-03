require 'spec_helper'

describe 'et_worker::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node, server|
      node.set['berkshelf_api']['home'] = '/etc/berkshelf/api-server'
      server.create_data_bag(
        'secrets',
        'api_keys' => {
          '_default' => {
            'chef' => {
              'berkshelf' => "-----BEGIN RSA PRIVATE KEY-----\nDUMMY_KEY\n-----END RSA PRIVATE KEY-----\n"
            },
            'github' => {
              'berkshelf' => 'DUMMY_GITHUB_API_TOKEN'
            }
          }
        }
      )

      server.update_node node
    end.converge(described_recipe)
  end

  before do
    stub_berkshelf_api_command
    stub_probymonitor_test
  end

  %w(
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
