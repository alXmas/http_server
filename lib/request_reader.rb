# frozen_string_literal: true

require 'require_all'
require_all 'lib'
require 'byebug'
module RequestReader
  REQUESTS = [Get, Post].freeze

  def self.call(source)
    lines = header(source[:request])
    if source[:server] == 'main'
      response = [Counter, Other]
    elsif source[:server] == 'proxy_1'
      response = [Counter, Other, StyleCss]
    elsif source[:server] == 'proxy_2'
      response = [Counter, Other, Html]
    end
    byebug
    request = REQUESTS.find { |request| request.can_call?(lines) }
    data = request.call(lines)
    response = response.find { |response| response.can_call?(data) }
    hash = {
      request: request,
      response: response,
      data: data,
      counter: request == Post ? lines.last.to_i : nil
    }
    response.call(hash)
  end

  def self.header(client)
    request_lines = []

    while (line = client.gets.chomp) && !line.empty?
      request_lines << line
    end
    request_lines
  end
end
