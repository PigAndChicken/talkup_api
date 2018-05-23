require 'dry-monads'
require 'dry/transaction'
require_relative './verify_container.rb'

module TalkUp

    module FeedbackService

        class Create
            include Dry::Transaction
            include Dry::Transaction(container: Container)

            step :current_account, with: "verify.current_account"
            step :current_comment, with: "verify.current_comment"
            step :add_feedback

            def add_feedback(input)
                result=  input[:account].add_feedback_to( input[:comment_id], input[:feedback_data] )
                
                if result.class == Hash
                   Left(Result.new(:bad_request, result))
                else
                   Right(Result.new(:created, result))
                end 
            end
        end
    end
end