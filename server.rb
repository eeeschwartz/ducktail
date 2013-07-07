require 'em-websocket'
require "eventmachine-tail"


class Reader < EventMachine::FileTail
  def initialize(path, startpos=-1)
    super(path, startpos)
    puts "Tailing #{path}"
    @buffer = BufferedTokenizer.new
  end

  def receive_data(data)
    @buffer.extract(data).each do |line|
      puts "#{path}: #{line}"
    end
  end
end

EM.run {
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"

      # Access properties on the EM::WebSocket::Handshake object, e.g.
      # path, query_string, origin, headers

      # Publish message to the client
      ws.send "Hello Client, you connected to #{handshake.path}"
    }

    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
      ws.send "Pong: #{msg}"
    }

    EventMachine::file_tail("/Users/erik/tmp/tdd.log") do |filetail,linenum|
      filetail.instance_variable_set(:@websocket, ws)

      def filetail.receive_data(data)
        p 'got data! ' + data
        @websocket.send data
      end
    end
  end
}
