require 'spec_helper'

describe 'et_worker::probymonitor' do
  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  before do
    mock_encrypted_data_bag_items
    stub_berkshelf_api_command
  end

  it 'deletes /usr/bin/probymonitor.sh' do
    expect(chef_run).to delete_template '/usr/bin/probymonitor.sh'
  end

  it 'deletes a probymonitor cron' do
    expect(chef_run).to delete_cron 'probymonitor'
  end
end
