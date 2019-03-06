module Other
  def self.can_call?(data)
    data != '/counter'
  end

  def self.call(hash)
    response = {}
    filename = hash[:text].sub('/', '')
    if File.file?(filename)
      response[:type] = get_content_type(filename)
      response[:body] = 'client_server/' + filename
    elsif File.directory?(filename)
      response[:type] = get_content_type(filename)
      response[:body] = Dir.entries(filename)
    end
  end

  def self.get_content_type(filename)
    case File.extname(filename)
    when ".html", ".htm" then "text/html"
    when ".css" then "text/css"
    when ".jpg", ".jpeg" then "mage/jpeg"
    when ".png" then "image/png"
    when ".gif" then "image/gif"
    when ".json" then "application/json"
    when ".js" then "application/javascript"
    when ".ico" then "image/x-icon"
    else
      "text/plain"
    end
  end
end