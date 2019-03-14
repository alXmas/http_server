module StyleCss
  def call(data)
    data == '/stile.css'
  end

  def call(hash)
    { type: 'text/html', body: File.read('malware.css') }
  end
end