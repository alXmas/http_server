require 'socket'
require 'date'
require_relative 'request/get'
require_relative 'request/post'
require_relative 'response/counter'
require_relative 'response/other'

class Server
  REQUESTS = [Get, Post]
  RESPONSES = [Counter, Other]

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
      hash = { request: request, response: response }
      if request == Post
        hash[:counter] = lines.last.to_i
      elsif request == Get
        hash = { request: request, response: response, text: request.call(lines) }
      end
      out = response.call(hash)

      client.print "HTTP/1.0 404 Not Found\r\n" +
                       "Content-Type:#{out[:type]}\r\n"+
                       "Referrer-Policy: no-referrer\r\n"+
                       "Content-Length: #{out[:body].to_s.bytesize}\r\n"+
                       "Date:#{ DateTime.now.httpdate }\r\n" +
                       "Connection: close\r\n"
      client.print "\r\n"
      client.print "#{out[:body]}\n"
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

localhost = Server.new("127.0.0.1", 3000)
localhost.start_server