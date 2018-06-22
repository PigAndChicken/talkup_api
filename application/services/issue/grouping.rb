# require 'dry-monads'
# require 'dry/transaction'
# require_relative '../verify_container.rb'

# module TalkUp

#     module IssueService
        
#         class GroupingComment   
#             include Dry::Transaction 
#             include Dry::Transaction(container: Container)
            
#             step :current_account, with: "verify.current_account"
#             step :current_issue, with: "verify.current_issue"
#             step :grouping

                        
#             def grouping(input)
#                 comments = input[:current_issue].comments
#                 like_comments = comments.sort_by {|c| c.feedbacks.select{|f| f.description =='like'}.length}.reverse
#                 confusing_comments = comments.sort_by {|c| c.feedbacks.select{|f| f.description =='confusing'}.length}.reverse
#                 dislike_comments = comments.sort_by {|c| c.feedbacks.select{|f| f.description =='dislike'}.length}.reverse
#                 interesting_comments = comments.sort_by {|c| c.feedbacks.select{|f| f.description =='interesting'}.length}.reverse
#                 hash = {
#                     like_comments: top_five(like_comments),
#                     confusing_comments: top_five(confusing_comments),
#                     dislike_comments: top_five(dislike_comments),
#                     interesting_comments: top_five(interesting_comments)
#                 }
#                 build_entity(hash)
#             end

#             private
#             def top_five(comments)
#                 return comments if comments.length < 5
#                 comments[comments.length-5..comments.length]
#             end

#             def build_entity(hash)
#                 Grouping.new(hash)
#             end

#             class Grouping
#                 def initialize(comments)
#                     @like_comments = comments[:like_comments]
#                     @confusing_comments = comments[:confusing_comments]
#                     @dislike_comments = comments[:dislike_comments]
#                     @interesting_comments = comments[:interesting_comments]
#                 end

#                 attr_reader :like_comments, :confusing_comments, :dislike_comments, :interesting_comments
#             end

#         end
#     end
# end