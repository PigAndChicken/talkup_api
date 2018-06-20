require "dry/transaction"
require "dry/transaction/operation"

module TalkUp
    class CurrentAccount
        include Dry::Transaction::Operation

        def call(input)
            input[:current_account] = Repo::Account.find_by(:username, input[:username])
            if input[:current_account] != nil
                input[:account] = Repo::Account.new(input[:username])
                Right(input)
            else
                Left(Result.new(:bad_request, 'Account information Error.'))
            end
        end
    end

    class CurrentIssue
        include Dry::Transaction::Operation

        def call(input)
            input[:current_issue] = Repo::Issue.find_by(:id, input[:issue_id])[0]
            if  input[:current_issue] != nil 
                Right(input)
            else
                Left(Result.new(:bad_request, 'Issue Information Error.'))
            end
        end
    end


    class CurrentComment
        include Dry::Transaction::Operation

        def call(input)
            if Repo::Comment.find_by(:id, input[:comment_id])[0] != nil 
                Right(input)
            else
                Left(Result.new(:bad_request, 'Comment Information Error.'))
            end
        end
    end
end
