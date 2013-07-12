require 'em-websocket'
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
