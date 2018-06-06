require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module IssueService

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
                input[:issue].set_policy(account)
                input[:issue].comments.each {|comment| comment.set_policy(account)}
                if input[:issue].policy.can_view
                    Right(Result.new(:ok, input[:issue]))
                else
                    Left(Result.new(:not_found, "Issue not found"))
                end
            end
        end
    end
end