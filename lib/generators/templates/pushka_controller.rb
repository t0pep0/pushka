require 'rubygems'
require 'daemons'

options = {:app_name => 'pushka',
           :ARGV => ARGV,
           :dir_mode => :script,
           :dir => '../tmp/pids',
           :log_output => false,
           :multiple => false,
           :ontop => false,
           :mode => :load,
           :backtrace => false,
           :monitor => false
}

Daemons.run(File.join(File.dirname(__FILE__), '../lib/pushka_daemon.rb'), options)
