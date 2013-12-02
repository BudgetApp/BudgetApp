require 'faye'
faye_server = Faye::RackAdapter.new(:mount => '/friends/feed/faye', :timeout => 45)
run faye_server