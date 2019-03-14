# frozen_string_literal: true

require 'json'

module Counter
  @counter = 0
  def self.can_call?(data)
    data == '/counter'
  end

  def self.call(hash)
    if hash[:counter].nil?
      { type: 'text/plain', body: @counter.to_s }
    else
      @counter += hash[:counter]
      { type: 'application/json', body: { 'message': 'success' }.to_json }
    end
  end
end
