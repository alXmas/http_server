# frozen_string_literal: true

require 'socket'
require_relative '../lib/request_reader'
require_relative '../lib/response_out'

class Server
  def initialize(host, port)
    @host = host
    @port = port
  end

  def start_server
    server = TCPServer.open(@host, @port)
    puts "Main server started on #{@host}:#{@port} ..."

    loop do
      client = server.accept
      request = RequestReader.call(request: client, server: 'main')
      byebug
      out = ResponseOut.call(request)
      client.write out[:header]
      client.write "\r\n"
      client.write out[:body] + "\n"
      client.close
    end
  end
end

localhost = Server.new('127.0.0.1', 3000)
localhost.start_server
