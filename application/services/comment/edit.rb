require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module CommentService

        class Edit
            include Dry::Transaction
            include Dry::Transaction(container: Container)

            step :current_account, with: "verify.current_account"
            step :policy_check
            step :edit_comment

            def policy_check(input)
                result = TalkUp::Repo::Comment.find_by(:id, input[:comment_id])[0]
                result.set_policy(input[:current_account])
                if result.policy.can_edit
                    Right(input)
                else
                    Left(Result.new(:bad_request, 'Cannot allowed.'))
                end
            end

            def edit_comment(input)
                result = TalkUp::Repo::Comment.update(input[:comment_id], input[:comment_data])
                result.set_policy(input[:current_account])                   
                if !result.nil? 
                    Right(Result.new(:ok, result))
                else
                    Left(Result.new(:bad_request, 'Delete failed'))
                end
            end
        end
    end
end