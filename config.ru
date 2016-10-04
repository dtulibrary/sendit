# This file is used by Rack-based servers to start the application.

if "development".eql?(ENV['RACK_ENV'])
  require 'debugger'
  Debugger.start_remote
end

require ::File.expand_path('../config/environment',  __FILE__)
run Tsushin::Application
