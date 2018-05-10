require 'dry-monads'
require 'dry/transaction'

module TalkUp

    module IssueService
        extend Dry::Monads::Either::Mixin

        def self.all
            issues = Repo::Issue.all
            if !issues.empty?
                Right(Result.new(:ok, issues))
            else
                Left(Result.new(:not_found, 'Cound not find any.'))
            end
        end

        def self.find_by(issue_id)
            issue = Repo::Issue.find_by(:id, issue_id)[0]
            if !issue.nil?
                Right(Result.new(:ok, issue))
            else
                Left(Result.new(:not_found, 'Cound not find any.'))
            end
        end
        
        class Create
            include Dry::Transaction

            step :current_account
            step :create_issue

            def current_account(input)
                if Repo::Account.find_by(:username, input['username']) != nil
                    input[:account] = Repo::Account.new(input['username'])

                    Right(input)
                else
                    Left(Result.new(:bad_request, 'Account information Error.'))
                end
            end

            def create_issue(input)
               result = input[:account].create_issue(input['issue_data'])
               if result.class == Hash
                   Left(Result.new(:bad_request, result))
               else
                   Right(Result.new(:created, result))
               end 
            end
        end
    end
end