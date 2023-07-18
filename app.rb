# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'

require 'open-uri'
require 'nokogiri'
require 'json'

class App < Sinatra::Application
  get '/' do
    html = URI.open(params['url']).read
    doc = Nokogiri::HTML.parse(html)

    {
      title: doc.title,
      image_url: doc.css('meta[property="og:image"] @content')
    }.to_json
  end
end
