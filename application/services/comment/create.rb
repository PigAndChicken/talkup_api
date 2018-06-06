require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module CommentService

        class Create
            include Dry::Transaction
            include Dry::Transaction(container: Container)

            step :current_account, with: "verify.current_account"
            step :current_issue, with: "verify.current_issue"
            step :add_comment

            def add_comment(input)
                result=  input[:account].add_comment_to(input[:issue_id], input[:comment_data])
                if result.class == Hash
                    Left(Result.new(:bad_request, result))
                else
                    result.set_policy(Repo::Account.find_by(:username, input[:username]))
                    Right(Result.new(:created, result))
                end 
            end
        end
    end
end