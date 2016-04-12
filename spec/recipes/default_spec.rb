require 'spec_helper'

describe 'et_worker::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe)
  end

  %w(
    postfix::server
    stale-node-checker
  ).each do |recipe|
    it "includes #{recipe}" do
      expect(chef_run).to include_recipe recipe
    end
  end
end
