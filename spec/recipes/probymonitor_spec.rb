require 'spec_helper'

describe 'et_worker::probymonitor' do
  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  before do
    mock_encrypted_data_bag_items
    stub_berkshelf_api_command
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
