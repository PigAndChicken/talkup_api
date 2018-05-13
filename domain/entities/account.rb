require 'dry-struct'

module TalkUp

    module Entity
        
        class Account < Dry::Struct

            attribute :id, Types::Strict::Int
            attribute :username, Types::Strict::String
            attribute :email, Types::Strict::String
            attribute :password_hash, Types::Strict::String
            attribute :salt, Types::Strict::String



            def issues
                Repo::Issue.find_by(:owner_id, @id)
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