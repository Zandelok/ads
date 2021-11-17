require_relative './controller_login'

RSpec.configure do |config|
  config.extend ControllerLogin, type: :controller
end
