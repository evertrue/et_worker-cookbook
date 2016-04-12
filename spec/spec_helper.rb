require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.log_level = :fatal
  config.color = true
  config.formatter = 'documentation'
end
