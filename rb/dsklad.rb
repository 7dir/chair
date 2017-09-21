require 'sidekiq'
require 'erb'
require 'json'
require "awesome_print"
require 'open-uri'
require 'uri'
require 'nokogiri'

require 'translit'
require 'facets'






class Geti
  include Sidekiq::Worker

  def perform(url, name)
    if File.exist? 'images/products/'+name+'/'+File.basename(url)
      puts 'already downloaded'
    else
      # Dir.mkdir 'images/products/'+name
      download = open(url)
      IO.copy_stream( download, 'images/products/'+name+'/'+File.basename(url) )
    end
  end
end








def get_template()
  %{---
title: <%= @title %>
description: <%= @desc_mini %>
price: '<%= @price %>'
image: <%= @main_img %>
sizes:
  - Small
images: <% for @image in @images %>
  - <%= @image %><% end %>
colors: <% for @color in @colors %>
  - <%= @color %><% end %>
---
<%= @desc %>
  }
end












class ShoppingList
  include ERB::Util
  attr_accessor :items, :template, :date

  def initialize( main_img, title, price, desc, colors, images, template, date=Time.now)
    @date = date

    @title = title
    @price = price
    @desc = desc
    @colors = colors
    @images = images
    @main_img = main_img
    @desc_mini = desc[0..30] if desc

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


json_filename='dsklad.json'
# filename='en.json'
file = File.read(json_filename)

# data_hash2 = JSON.parse file
# p data_hash2['Products'].size

data_hash = JSON.parse( 
  file
    # .gsub('/[^[:print:]]/', '')
    # .gsub(/.400x400/, '')
    # .gsub(/.60x60/, '')
    # .gsub(/.32x32/, '')
    # .gsub(/.search/, '')
    # .gsub('\"', '\'')
    # .gsub(/\n/, '')
    # .gsub('\n', '')
    # .gsub(/\t/, '')
    # .gsub('.–', '')
    # .gsub('  ', '')
    # .gsub(/\"/, "'")
  )

# p data_hash['Products'][0]

data_hash["Products"].each_with_index  { |e, i|

  # ["url", "price", "name", "detail", "addon_imgs", "colors", "main_imgs"]
  e["main_imgs"].each_with_index  do |image, i2|

    url = image['url']
    uri = URI.parse(url)
    if File.basename(uri.path)!='lazyload.png'
      data_hash["Products"][i]["main_imgs"][i2]['url']=File.basename(url)
      # p image['url']
      # Geti.perform_async(url, Translit.convert(e['name']).snakecase)
    else
      data_hash["Products"][i]["main_imgs"][i2].delete('url')
      # e["main_imgs"].reject!(&:empty?)
    end
  end
  # converted_text = Iconv.conv('iso-8859-15', 'utf-8', e['name'])
}


data_hash["Products"].each_with_index { |e, k|

  imgs=[]
  e["main_imgs"].each { |i|
    if i.empty? !=true
      imgs.push i['url']
    end
  }
  imgs = imgs.uniq
  
  colors=[]
  e["colors"].each { |i|
    if i.empty? !=true
      colors.push i['name']
    end
  } if e["colors"]


  # p e['name']
  # p Translit.convert(e['name']).snakecase
  # p e['price']
  # p e['desc']
  # p colors

  filename = Translit.convert(e['name']).snakecase
  d = 'images/products/'+filename
  Dir.mkdir d if not Dir.exist? d

  # Geti.perform_async(e['image'], filename)
  
  price = e['price'].gsub('.–','').gsub(' ','')

  ur = URI.parse(e['image'])
  main_img = File.basename(ur.path)
  


  list = ShoppingList.new(main_img, e['name'], price, e['desc'], colors, imgs, get_template)
  list.save('_products/'+filename+'.md')

  # break if k > 20
}

# p data_hash["Products"].size
# p data_hash2["Products"].size