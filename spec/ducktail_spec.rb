require 'helper'
require 'ducktail'
require 'tempfile'

describe DuckTail do
  context 'when a line is appended to the tailed file' do
    it 'pushes the line to the websocket' do
      file = Tempfile.new('a.log')
      server = double('websocket', send: true)
      DuckTail.new(file, server)
      data = 'foo'

      EM.run do
        EM::Timer.new(0.2) do
          file.write(data)
          file.flush
          EM::Timer.new(0.2) do
            EM.stop_event_loop
          end
        end
      end
      expect(server).to have_received(:send).with(data)
    end
  end
end
