# frozen_string_literal: true

require 'date'

module ResponseOut
  def call(request)
    { header:
         "HTTP/1.0 #{request.nil? ? '404 Not Found' : '200 OK'}\r\n" \
                   "Content-Type: #{request.nil? ? '' : request[:type]}; charset=utf-8\r\n" \
                   "Referrer-Policy: no-referrer\r\n" \
                   "Content-Length: #{request.nil? ? '404 Not Found'.bytesize : request[:body].to_s.bytesize}\r\n" \
                   "Date:#{DateTime.now.httpdate}\r\n" \
                   "Connection: close\r\n",
     body: request[:body] }
    end
end
