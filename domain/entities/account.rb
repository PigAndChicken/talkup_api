require 'dry-struct'

module TalkUp

    module Entity
        
        class Account < Dry::Struct

            attribute :id, Types::Strict::Int
            attribute :username, Types::Strict::String
            attribute :email, Types::Strict::String
            attribute :password_hash, Types::Strict::String
            attribute :salt, Types::Strict::String
            

            def policy
            end

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

            def password?(try_password)
                try_hash = SecureDB.hash_password(@salt, try_password)
                try_hash == @password_hash
            end

        end
    end
end