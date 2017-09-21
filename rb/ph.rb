require "awesome_print"
require 'json'
require 'zlib'
require 'stringio'

# require 'net/http'

# params = {
#   :api_key => "t8E6j-vQScxk",
#   :format => "json"
# }
# url = URI.parse('https://www.parsehub.com/api/v2/projects/tZ7WJTFmgEtD/last_ready_run/data')
# url.query = URI.encode_www_form(params)

# puts Net::HTTP.get(url)


# require 'net/http'

# params = {
#   :api_key => "t8E6j-vQScxk",
#   :offset => "0",
#   :limit => "20",
#   :include_options => "1"
# }

# url = URI.parse('https://www.parsehub.com/api/v2/projects')
# url.query = URI.encode_www_form(params)


# gz = Zlib::GzipReader.new(StringIO.new(Net::HTTP.get(url)))
# uncompressed_string = gz.read

# ap uncompressed_string

# ap JSON.pretty_generate( JSON.parse() )
# p 
# my_object = { :array => [1, 2, 3, { :sample => "hash"} ], :foo => "bar" }
# p JSON.pretty_generate(Net::HTTP.get(url))









require 'net/http'

params = {
  :api_key => "t8E6j-vQScxk",
  :format => "csv"
}
url = URI.parse('https://www.parsehub.com/api/v2/runs/tZ7WJTFmgEtD/data')
url.query = URI.encode_www_form(params)

puts Net::HTTP.get(url)
