require_relative '../init.rb'

require 'rack/test'
require 'hirb'

include Rack::Test::Methods

Hirb.enable

old_print = Pry.config.print
Pry.config.print = proc do |*args|
  Hirb::View.view_or_page_output(args[1]) || old_print.call(*args)
end

def app
    TalkUp::Api
end


ISSUES_DATA = YAML.safe_load File.read('./infrastructure/database/seeds/issue_seeds.yml')
COMMENTS_DATA = YAML.safe_load File.read('./infrastructure/database/seeds/comment_seeds.yml')
