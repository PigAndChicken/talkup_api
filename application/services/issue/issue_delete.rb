require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module IssueService
        
        class Delete   
            include Dry::Transaction 
            include Dry::Transaction(container: Container)


            step :current_account, with: "verify.current_account"
            step :current_issue, with: "verify.current_issue"
            step :verify_policy
            step :delete_issue
            
            def verify_policy(input)
                issue_policy = IssuePolicy.new(input[:current_account], input[:current_issue])
                if issue_policy.can_delete?
                    Right(input)
                else
                    Left(Result.new(:bad_request, 'Not authorizated'))
                end

            end

            def delete_issue(input)
                result = Repo::Issue.delete(input[:issue_id])

                if result.nil?
                    Left(Result.new(:bad_request, 'Updated issue failed'))
                else
                    Right(Result.new(:ok, "Issue #{input[:issue_id]} deleted."))
                end

            end

        end
    end
end