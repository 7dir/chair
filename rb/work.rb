require 'sidekiq'
require 'erb'
require 'json'
require "awesome_print"
require 'open-uri'
require 'uri'

class Geti
  include Sidekiq::Worker

  def perform(url)
    if File.exist? 'images/products/'+File.basename(url)
      puts 'already downloaded'
    else
      download = open(url)
      IO.copy_stream( download, 'images/products/'+File.basename(url) )
    end
  end
end








def get_template()
  %{
---
title: <%= @title %>
description: <%= @desc %>
price: '<%= @price %>'
sizes:
  - Small
images: <% for @image in @images %>
  - image_path: <%= @image %><% end %>
styles:
  - name: Cream
    color: '#dfd3c2'
    image_path: /images/products/elephant/cream.jpg
featured_image_path: '/images/products/elephant/cream.jpg'
facebook_image_path:
---
<%= @desc %>
  }
end












class ShoppingList
  include ERB::Util
  attr_accessor :items, :template, :date

  def initialize(title, price, desc, text, images, template, date=Time.now)
    @date = date

    @title = title
    @price = price
    @desc = desc
    @text = text
    @images = images

    @template = template

    # @images.each do |image|
    #   puts image['Url']
    # end
  end

  def render()
    ERB.new(@template).result(binding)
  end

  def save(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

end














# list = ShoppingList.new('title', '45.14', 'desc', 'long text', get_images, get_template)
# # list.save(File.join(ENV['HOME'], 'list.html'))
# list.save('_products/list.md')


filename='zh.json'
# filename='en.json'
file = File.read(filename)

data_hash2 = JSON.parse file
p data_hash2.size

data_hash = JSON.parse( 
  file
    .gsub('/[^[:print:]]/', '')
    .gsub(/.400x400/, '')
    .gsub(/.60x60/, '')
    .gsub(/.32x32/, '')
    .gsub(/.search/, '')
  )



data_hash["Product"].each_with_index  { |e, i|

  # ["url", "price", "name", "detail", "addon_imgs", "colors", "main_imgs"]
  e["main_imgs"].each_with_index  do |image, i2|

    url = image['url']
    uri = URI.parse(url)
    if File.basename(uri.path)!='lazyload.png'
      # Geti.perform_async(url)
      data_hash["Product"][i]["main_imgs"][i2]['url']=File.basename(url)
      # p image['url']
    else
      data_hash["Product"][i]["main_imgs"][i2].delete('url')
      # e["main_imgs"].reject!(&:empty?)
    end
  end

  # converted_text = Iconv.conv('iso-8859-15', 'utf-8', e['name'])

}

data_hash["Product"].each { |e, k| 
  imgs=[]
  e["main_imgs"].each { |i|
    if i.empty? !=true
      imgs.push i['url']
    end
    # p i['url']
  }

  # list = ShoppingList.new(e['name'], e['price'], '', e['detail'], imgs, get_template)
  # list.save(File.join(ENV['HOME'], 'list.html'))
  # list.save('_products/'+e['name']+'.md')
  # p e['name']
  # p imgs

}

p data_hash["Product"].size
p data_hash2["Product"].size