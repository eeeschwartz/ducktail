require './lib/ducktail'

EM.run do
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |server|
    server.onopen do |handshake|
      puts "WebSocket connection open"
      server.send "Hello Client"
    end
    DuckTail.new(File.new(ARGV[0]), server)
  end
end
