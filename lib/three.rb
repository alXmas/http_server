require 'nokogiri'

module Three
  def self.call(out)
    document = Nokogiri::HTML.parse(out[:body])
    data = Nokogiri::HTML.parse("<script type='text/javascript'>")
    document.css('head') << data
  end
end