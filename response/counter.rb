module Counter
  @counter = 0
  def self.can_call?(data)
    data == '/counter'
  end

  def self.call(hash)
    response = {}
    if hash[:request] == Get
      response[:type] = ' text/plain'
      response[:body] = @counter
    elsif hash[:request] == Post
      @counter += hash[:counter]
      response[:type] = 'application/json'
      response[:body] = 'json {“message”:”success”}'
    end
    response
  end
end