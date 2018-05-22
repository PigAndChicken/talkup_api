require 'dry-container'
require_relative './operation/verify_current.rb'

class Container
    extend Dry::Container::Mixin

    namespace "verify" do |ops|
        ops.register "current_account" do
            CurrentAccount.new
        end
        ops.register "current_issue" do
            CurrentIssue.new
        end
        ops.register "current_comment" do
            CurrentComment.new
        end  
    end

end