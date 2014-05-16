require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/server'

RSpec.configure do |config|
  config.log_level = :fatal
end

def mock_encrypted_data_bag_items
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
    'probymonitor' => 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    '_default' => {
      'chef' => {
        'berkshelf' => "-----BEGIN RSA PRIVATE KEY-----\nDUMMY_KEY\n-----END RSA PRIVATE KEY-----\n"
      },
      'github' => {
        'berkshelf' => 'DUMMY_GITHUB_API_TOKEN'
      }
    }
  )
end

def stub_berkshelf_api_command
  # Stubbing a command that's executed in the Berkshelf API cookbook
  stub_command(
    'cd /opt/berkshelf-api/v1.3.1 && /opt/chef/embedded/bin/bundle check'
  ).and_return(
    'The Gemfile\'s dependencies are satisfied'
  )
end
