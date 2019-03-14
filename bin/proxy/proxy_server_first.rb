# frozen_string_literal: true

require 'socket'
require 'lib/request_reader'

class ProxyServerFirst
  def initialize(host, port)
    @host = host
    @port = port
  end

  def start_server
    server = TCPServer.open(@host, @port)
    puts "Proxy server started on #{@host}:#{@port} ..."


    loop do
      client = server.accept
      request = RequestReader.call(request: client, server: 'proxy_1')
      out = ResponseOut.call(request)
      client.write out[:header]
      client.write "\r\n"
      client.write out[:body] + "\n"
      client.close
    end
  end
end

localhost = ProxyServerFirst.new('127.0.0.1', 2000)
localhost.start_server
