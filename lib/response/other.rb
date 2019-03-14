# frozen_string_literal: true

module Other
  def self.can_call?(data)
    data != '/counter'
  end

  def self.call(hash)
    filename = filename(hash[:data])
    if File.file?(filename)
      { type: get_content_type(filename),
        body: File.read(filename) }
    elsif File.directory?(filename)
      { type: get_content_type(filename),
        body: Dir.entries(filename) }
    end
  end

  def self.filename(hash)
    hash[:text] = if hash[:text] == '' || hash[:text] == '/'
                    '../http_server'
                  else
                    hash[:text].sub('/', '')
                  end
  end

  def self.get_content_type(filename)
    case File.extname(filename)
    when '.html', '.htm' then 'text/html'
    when '.css' then 'text/css'
    when '.jpg', '.jpeg' then 'mage/jpeg'
    when '.png' then 'image/png'
    when '.gif' then 'image/gif'
    when '.json' then 'application/json'
    when '.js' then 'application/javascript'
    when '.ico' then 'image/x-icon'
    else
      'text/plain'
    end
  end

end
