require 'httparty'
require 'nokogiri'
require 'extractimag/version'

module Extractimag
  include ::HTTParty

  parser proc { |data| ::Nokogiri::HTML(data) }

  def self.images(url)
    doc = get(url).parsed_response
    extract_images(doc, url)
  end

  def self.extract_images(doc, base_url)
    doc
      .css('img')
      .map { |el| el['src'] }
      .map { |rel| URI.join(base_url, rel).to_s }
  end
end
