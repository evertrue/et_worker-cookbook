require 'spec_helper'

describe 'et_worker::default' do
  describe file '/usr/local/bin/aws-cleanup' do
    it { is_expected.to be_mode 755 }
  end

  describe file '/etc/cron.d/awscleanup' do
    it { is_expected.to contain '20 * * * * root /usr/local/bin/aws-cleanup' }
  end
end
