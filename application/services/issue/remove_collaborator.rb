require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module IssueService
        
        class RemoveCollaborator
            include Dry::Transaction 
            include Dry::Transaction(container: Container)
            
            step :current_account, with: "verify.current_account"
            step :current_issue, with: "verify.current_issue"
            step :verify_policy
            step :remove_collaborator

                        
            def verify_policy(input)
                issue_policy = IssuePolicy.new(input[:current_account], input[:current_issue])
                if issue_policy.can_remove_collaborators?
                    Right(input)
                else
                    Left(Result.new(:bad_request, 'Not authorizated'))
                end
            end

            def remove_collaborator(input)
                result = input[:account].remove_collaborator(input[:issue_id], input[:collaborator])
                if result.nil?
                    Left(Result.new(:bad_request, 'Collaborators not found'))
                else
                    Right(Result.new(:ok, result))
                end
            end

        end
    end
end