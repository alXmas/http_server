# frozen_string_literal: true

module Post
  def self.can_call?(request)
    request[0].split[0] == 'POST'
  end

  def self.call(request)
    request[0].split[1]
  end
end
