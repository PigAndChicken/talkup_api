require 'dry-monads'

module TalkUp

    module FindIssuesIndex
        extend Dry::Monads::Either::Mixin

        def self.all
            issues = Repo::Issue.all
            if !issues.empty?
                Right(Result.new(:ok, issues))
            else
                Left(Result.new(:not_found, 'Cound not find any.'))
            end
        end
    end
end