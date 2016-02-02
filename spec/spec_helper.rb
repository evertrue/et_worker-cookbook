require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.log_level = :fatal
  config.color = true
  config.formatter = 'documentation'
end

def stub_berkshelf_api_command
  # Stubbing a command that's executed in the Berkshelf API cookbook
  stub_command(
    'cd /opt/berkshelf-api/v2.1.1 && /opt/chef/embedded/bin/bundle check'
  ).and_return(
    'The Gemfile\'s dependencies are satisfied'
  )
end
