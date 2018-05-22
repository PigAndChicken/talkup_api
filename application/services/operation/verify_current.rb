require "dry/transaction"
require "dry/transaction/operation"

class CurrentAccount
    include Dry::Transaction::Operation

    def call(input)
        if Repo::Account.find_by(:username, input['username']) != nil
            input[:account] = Repo::Account.new(input['username'])
            Right(input)
        else
            Left(Result.new(:bad_request, 'Account information Error.'))
        end
    end
end

class CurrentIssue
    include Dry::Transaction::Operation

    def call(input)
        if Repo::Issue.find_by(:id, input['issue_id']) != nil 
            Right(input)
        else
            Left(Result.new(:bad_request, 'Issue Information Error.'))
        end
    end
end