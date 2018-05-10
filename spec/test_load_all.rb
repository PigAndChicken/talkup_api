# Run 'pry -r <path/to/this/file'
require './init.rb'
require 'rack/test'

include Rack::Test::Methods

def app
  TalkUp::Api
end
