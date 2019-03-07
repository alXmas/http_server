# frozen_string_literal: true

module Get
  def self.can_call?(request)
    request[0].split[0] == 'GET'
  end

  def self.call(request)
    request[0].split[1]
  end
end
