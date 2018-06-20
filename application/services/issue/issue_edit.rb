require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module IssueService
        
        class Edit   
            include Dry::Transaction 
            include Dry::Transaction(container: Container)


            step :current_account, with: "verify.current_account"
            step :current_issue, with: "verify.current_issue"
            step :verify_policy
            step :update_issue
            
            def verify_policy(input)
                issue_policy = IssuePolicy.new(input[:current_account], input[:current_issue])
                if issue_policy.can_edit?
                    Right(input)
                else
                    Left(Result.new(:bad_request, 'Not authorizated'))
                end

            end

            def update_issue(input)
                result = Repo::Issue.update(input[:issue_id], input[:issue_data])

                if result.nil?
                    Left(Result.new(:bad_request, 'Updated issue failed'))
                else
                    result.set_policy(input[:current_account])
                    result.comments.each {|c| c.set_policy(input[:current_account])}
                    Right(Result.new(:ok, result))
                end

            end

        end
    end
end