require 'spec_helper'

describe 'Berkshelf API Server' do
  describe 'Proxy Server' do
    describe port(80) do
      it { should be_listening.with('tcp') }
    end
  end

  describe 'Berks API' do
    describe service('berks-api') do
      it { should be_running }
    end

    describe port(26_200) do
      it { should be_listening.with('tcp') }
    end
  end
end
