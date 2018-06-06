require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module IssueService

        class Create
            include Dry::Transaction    
            include Dry::Transaction(container: Container)


            step :current_account, with: "verify.current_account"
            step :create_issue

            def create_issue(input)
               result = input[:account].create_issue(input[:issue_data])
               if result.class == Hash
                   Left(Result.new(:bad_request, result))
               else
                    account = Repo::Account.find_by(:username, input[:username])
                    result.set_policy(account)
                    Right(Result.new(:created, result))
               end 
            end
        end
    end
end