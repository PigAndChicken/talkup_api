require 'dry-monads'
require 'dry/transaction'
require_relative './verify_container.rb'

module TalkUp

    module IssueService
        extend Dry::Monads::Either::Mixin

        def self.all(section)
            issues = Repo::Issue.all(section)
            if !issues.empty?
                Right(Result.new(:ok, issues))
            else
                Left(Result.new(:not_found, 'Cound not find any.'))
            end
        end

        def self.find_by(issue_id )
            issue = Repo::Issue.find_by(:id, issue_id)[0]
            if !issue.nil?
                Right(Result.new(:ok, issue))
            else
                Left(Result.new(:not_found, 'Cound not find any.'))
            end
        end
        
        def self.delete(issue_id)
            result = Repo::Issue.delete(issue_id)
            if result == nil 
                Left(Result.new(:not_found, 'Could not find any.'))
            else
                Right(Result.new(:ok, result))
            end
        end

        class Detail
            include Dry::Transaction

            step :issue_exist?
            step :account_auth?

            def issue_exist?(input)
                issue = Repo::Issue.find_by(:id, input[:issue_id])[0]
                if !issue.nil?
                    input[:issue] = issue
                    Right(input)
                else
                    Left(Result.new(:not_found, 'Issue not exist'))
                end
            end
            def account_auth?(input)
                account = Repo::Account.find_by(:username, input[:username])
                issue_policy = IssuePolicy.new(account, input[:issue])
                input[:issue].set_policy(issue_policy)
                if issue_policy.can_view?
                    Right(Result.new(:ok, input[:issue]))
                else
                    Left(Result.new(:not_found, "Issue not found"))
                end
            end

        end

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
                   Right(Result.new(:created, result))
               end 
            end
        end
    end
end