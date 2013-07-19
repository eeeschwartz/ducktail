require 'em-websocket'
require 'evma_httpserver'
require 'eventmachine-tail'

class DuckTail
  def initialize(file, server)
    filetail = EventMachine::file_tail(file.path)
    filetail.instance_variable_set(:@server, server)

    def filetail.receive_data(data)
      @server.send data
    end
  end
end

class WebServer < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new(self)
    resp.status = 200
    resp.content = File.read('client.html')
    resp.send_response
  end
end
