require 'spec_helper'

describe 'et_worker::probymonitor' do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      # node.set['probymonitor']['task_id'] = ''
    end.converge(described_recipe)
  end

  before do
    Chef::EncryptedDataBagItem.stub(:load).with('secrets', 'api_keys').and_return(
      'probymonitor' => 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    )
  end

  it 'creates /usr/bin/probymonitor.sh' do
    expect(chef_run).to create_template('/usr/bin/probymonitor.sh').with(
      user: 'root',
      group: 'root',
      mode: 00755
    )
    expect(chef_run).to render_file('/usr/bin/probymonitor.sh').with_content(
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    )
  end

  it 'creates a probymonitor cron' do
    expect(chef_run).to create_cron('probymonitor').with(
      hour: '*',
      minute: '*',
      day: '*',
      month: '*',
      weekday: '*',
      user: 'nobody',
      shell: '/bin/bash',
      command: '/usr/bin/probymonitor.sh'
    )
  end
end
