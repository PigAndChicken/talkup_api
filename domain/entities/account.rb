require 'dry-struct'

module TalkUp

    module Entity
        
        class Account < Dry::Struct

            attribute :id, Types::Strict::Int
            attribute :type, Types::Strict::String
            attribute :username, Types::Strict::String
            attribute :email, Types::Strict::String

            def token
                AuthToken.create(@username)
            end

            def issues
                issues = Repo::Issue.find_by(:owner_id, @id) + Repo::Issue.find_by(:collaborator_id, @id)
                issues.map {|issue| issue.id}
            end

            def comments
                Repo::Comment.find_by(:commenter_id, @id)
            end

        end
    end
end