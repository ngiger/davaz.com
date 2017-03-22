#\ -w -p 11090
# 11090 must be in sync with TEST_SRV_URI from override_config.rb
root_dir = File.expand_path(File.join(__FILE__, '..', '..'))
$LOAD_PATH << File.join(root_dir, 'test')
require 'test_helper'
require 'support/stub/db_manager'
require 'support/yus_server'
puts "config.ru TEST_SRV_URI #{TEST_SRV_URI} "
use Rack::CommonLogger, ChronoLogger.new(TEST_CHRONO_LOGGER)
use Rack::Reloader, 0
use Rack::ContentLength
use(Rack::Static, urls: ["/doc/"])

rack_if = DaVaz::Util::RackInterface.new(db_manager: DaVaz::Stub::DbManager.new, yus_server: DaVaz.GetMockYusServer)
app = Rack::ShowExceptions.new(Rack::Lint.new(rack_if))
run app
