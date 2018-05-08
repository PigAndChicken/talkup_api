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
DATA[:feedback_description] = YAML.safe_load File.read('./infrastructure/database/seeds/feedback_description_seeds.yml')

DATA.each_key do |key|
  DATA[key].map {|element| element.symbolize_keys!}
end

include TalkUp

  
VIC = Database::AccountOrm.create(DATA[:accounts][0])
ISSUE = Database::IssueOrm.create(DATA[:issues][0])
COMMENT = Database::CommentOrm.create(DATA[:comments][0])
FE_DESC =  DATA[:feedback_description].map do |desc|
  Database::FeedbackDescriptionOrm.create(desc)
end

VIC.add_owned_issue(ISSUE)
VIC.add_collaboration(ISSUE)

VIC.add_comment(COMMENT)
ISSUE.add_comment(COMMENT)

FEEDBACK = Database::FeedbackOrm.new
FEEDBACK.account=VIC
FEEDBACK.comment=COMMENT
FEEDBACK.description=FE_DESC[0]
FEEDBACK.save