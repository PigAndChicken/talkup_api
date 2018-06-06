require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module CommentService

        class Delete
            include Dry::Transaction
            include Dry::Transaction(container: Container)

            step :current_account, with: "verify.current_account"
            step :policy_check
            step :delete_comment

            def policy_check(input)
                result = TalkUp::Repo::Comment.find_by(:id, input[:comment_id])[0]
                result.set_policy(Repo::Account.find_by(:username, input[:username]))
                if result.policy.can_delete
                    Right(input)
                else
                    Left(Result.new(:bad_request, 'Cannot allowed.'))
                end
            end

            def delete_comment(input)
                if TalkUp::Repo::Comment.delete(input[:comment_id])
                    Right(Result.new(:ok, 'Deleted'))
                else
                    Left(Result.new(:bad_request, 'Delete failed'))
                end
            end
        end
    end
end