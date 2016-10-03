# This file is used by Rack-based servers to start the application.

require 'debugger'
Debugger.start_remote

require ::File.expand_path('../config/environment',  __FILE__)
run Tsushin::Application
