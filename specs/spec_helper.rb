ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'rake'

load 'Rakefile'

Rake::Task['db:reset'].invoke



require_relative './test_load_all.rb'

DATA[:feedbacks].each do |feedback|
    TalkUp::Database::FeedbackDescriptionOrm.create(feedback.to_h)
end


def delete_all
    accounts = Database::AccountOrm.all
    accounts.each { |a| a.destroy } if !accounts.empty?
end