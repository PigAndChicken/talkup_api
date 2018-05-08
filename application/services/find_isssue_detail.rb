require 'dry-monads'

module TalkUp

    module FindIssueDetail
        extend Dry::Monads::Either::Mixin

        def self.find_by(issue_id)
            issue = Repo::Issue.find_by(:id, issue_id)[0]
            if !issue.nil?
                Right(Result.new(:ok, issue))
            else
                Left(Result.new(:not_found, 'Cound not find any.'))
            end
        end
    end
end