require 'nokogiri'
require 'spec_helper'

ONE = Nokogiri::HTML('<html><body><img src="/1.png"></body></html>').freeze
NONE = Nokogiri::HTML('<html><body></body></html>').freeze

describe Extractimag do
  it 'has a version number' do
    expect(Extractimag::VERSION).not_to be nil
  end

  it 'extracts some images from good urls' do
    expect(Extractimag.images('https://google.com')).to be_kind_of Array
    expect(Extractimag.images('http://yandex.ru')).to be_kind_of Array
  end

  it 'extracts images from String data' do
    expect(Extractimag.extract_images(ONE, 'http://foo.org')).to eq ['http://foo.org/1.png']
    expect(Extractimag.extract_images(NONE, 'http://foo.org')).to eq []
  end

  it 'throws exception with bad urls' do
    expect { Extractimag.images('a') }.to raise_error Errno::ECONNREFUSED
    expect { Extractimag.images('a:/b') }.to raise_error "'a:/b' Must be HTTP, HTTPS or Generic"
  end
end
