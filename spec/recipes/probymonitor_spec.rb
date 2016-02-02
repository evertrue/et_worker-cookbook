require 'spec_helper'

describe 'et_worker::probymonitor' do
  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  before do
    stub_berkshelf_api_command
    stub_probymonitor_test
  end

  it 'deletes /usr/bin/probymonitor.sh' do
    expect(chef_run).to delete_file '/usr/bin/probymonitor.sh'
  end

  it 'deletes a probymonitor cron' do
    expect(chef_run).to delete_cron 'probymonitor'
  end
end
