require_relative '../init.rb'

require 'rack/test'
require 'hirb'
require 'pry'

include Rack::Test::Methods

Hirb.enable

old_print = Pry.config.print
Pry.config.print = proc do |*args|
  Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
end

def app
    TalkUp::Api
end

DATA = {}
DATA[:issues] = YAML.safe_load File.read('./infrastructure/database/seeds/issue_seeds.yml')
DATA[:comments] = YAML.safe_load File.read('./infrastructure/database/seeds/comment_seeds.yml')

ISSUE_ONE = {
    :title_secure => SecureDB.encrypt(DATA[:issues][0]['name']),
    :description_secure => SecureDB.encrypt(DATA[:issues][0]['description']),
    :section => DATA[:issues][0]['section']
}

ISSUE_TWO = {
    :title_secure => SecureDB.encrypt(DATA[:issues][1]['name']),
    :description_secure => SecureDB.encrypt(DATA[:issues][1]['description']),
    :section => DATA[:issues][1]['section'],
    :process => DATA[:issues][1]['process']
}

COMMENT_ONE = {
    :content_secure => SecureDB.encrypt(DATA[:comments][0]['content']),   
}