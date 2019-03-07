# frozen_string_literal: true

require 'socket'
require 'date'
require 'byebug'
require 'require_all'
require_all 'lib'

class Server
  REQUESTS = [Get, Post].freeze
  RESPONSES = [Counter, Other].freeze

  def initialize(host, port)
    @host = host
    @port = port
  end

  def start_server
    server = TCPServer.open(@host, @port)
    puts "Server started on #{@host}:#{@port} ..."

    loop do
      client = server.accept
      lines = header(client)
      request = REQUESTS.find { |request| request.can_call?(lines) }
      data = request.call(lines)
      response = RESPONSES.find { |response| response.can_call?(data) }
      hash = { request: request,
               response: response,
               text: data,
               counter: request == Post ? lines.last.to_i : nil }
      out = response.call(hash)

      client.print "HTTP/1.0 #{out.nil? ? '404 Not Found' : '200 OK'}\r\n" \
                   "Content-Type: #{out.nil? ? '' : out[:type]}\r\n" \
                   "Referrer-Policy: no-referrer\r\n" \
                   "Content-Length: #{out.nil? ? '404 Not Found'.bytesize : out[:body].to_s.bytesize}\r\n" \
                   "Date:#{DateTime.now.httpdate}\r\n" \
                   "Connection: close\r\n"
      client.print "\r\n"
      client.print "#{out.nil? ? '404  Found' : out[:body]}\n"
      client.close
    end
  end

  def header(client)
    request_lines = []

    while (line = client.gets.chomp) && !line.empty?
      request_lines << line
    end
    request_lines
  end
end

localhost = Server.new('127.0.0.1', 3000)
localhost.start_server
