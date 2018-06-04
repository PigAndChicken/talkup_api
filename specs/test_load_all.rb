require_relative '../init.rb'

require 'rack/test'
require 'hirb'
require 'pry'
require 'facets'

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
DATA[:accounts] = YAML.safe_load File.read('./infrastructure/database/seeds/account_seeds.yml')
DATA[:feedbacks] = YAML.safe_load File.read('./infrastructure/database/seeds/feedback_description_seeds.yml')

DATA.each_key do |key|
  DATA[key].map {|element| element.symbolize_keys!}
end

include TalkUp

DATA1 = {"username"=>"", "email"=>"", "password" => ""}

co_user = [{username: 'Shelly'}, {username: 'SoumyaRay'}]


# DATA[:feedbacks].each do |f|
#   Database::FeedbackDescriptionOrm.create(f)
# end

VIC = TalkUp::Repo::Account.find_by(:username, "Vic")
SHELLY = TalkUp::Repo::Account.find_by(:username, 'Shelly')
ISSUE = TalkUp::Repo::Issue.find_by(:owner_id, VIC.id)[1]
