require 'dry-monads'

module TalkUp

    module FindIssueDetail
        extend Dry::Monads::Either::Mixin

        def self.find_by(issue_id)
            issue = Repo::Issue.find_by(:id, issue_id)
            if !issue.empty?
                Right(Result.new(:ok, issue[0].plaintext))
            else
                Left(Result.new(:not_found, 'Cound not find any.'))
            end
        end
    end
end