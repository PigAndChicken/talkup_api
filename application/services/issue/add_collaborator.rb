require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module IssueService
        
        class AddCollaborators   
            include Dry::Transaction 
            include Dry::Transaction(container: Container)
            
            step :current_account, with: "verify.current_account"
            step :current_issue, with: "verify.current_issue"
            step :verify_policy
            step :add_collaborators

                        
            def verify_policy(input)
                issue_policy = IssuePolicy.new(input[:current_account], input[:current_issue])
                if issue_policy.can_add_collaborators?
                    Right(input)
                else
                    Left(Result.new(:bad_request, 'Not authorizated'))
                end
            end

            def add_collaborators(input)
                result = input[:account].add_collaborators_to(input[:issue_id], input[:collaborators])
                if result.nil?
                    Left(Result.new(:bad_request, 'Collaborators not found'))
                else
                    Right(Result.new(:created, result))
                end
            end

        end
    end
end