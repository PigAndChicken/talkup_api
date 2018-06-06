require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module IssueService
        
        class All   
            include Dry::Transaction 

            step :get_all_issue
            step :set_policy

            def get_all_issue(input)
                issues = Repo::Issue.all(input[:section])
                if !issues.empty?
                    input[:issues] = issues
                    Right(input)
                else
                    Left(Result.new(:not_found, "Please Create a new one."))
                end
            end

            def set_policy(input)
                account = Repo::Account.find_by(:username, input[:username])
                Left(Result.new(:unauthorized, "Please login")) if account.nil?
                input[:issues].map do |issue|
                    issue.set_policy(account)
                end
                Right(Result.new(:ok, input[:issues]))
            end

        end
    end
end