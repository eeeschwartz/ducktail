require 'evma_httpserver'
require './lib/ducktail'

class WebServer < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new(self)
    resp.status = 200
    resp.content = File.read('client.html')
    resp.send_response
  end
end

EM.run do
  EventMachine::start_server('0.0.0.0', 8080, WebServer)
  puts 'Listening on 8080...'

  EM::WebSocket.run(host: '0.0.0.0', port: 8081) do |server|
    server.onopen do |handshake|
      puts 'WebSocket connection open'
      server.send 'Hello Client'
    end
    DuckTail.new(File.new(ARGV[0]), server)
  end
end
