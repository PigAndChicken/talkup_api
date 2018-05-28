require 'dry-struct'

module TalkUp

    module Entity
        
        class Account < Dry::Struct

            attribute :id, Types::Strict::Int
            attribute :username, Types::Strict::String
            attribute :email, Types::Strict::String
            attribute :password_hash, Types::Strict::String
            attribute :salt, Types::Strict::String
            

            def token
                AuthToken.create(@username)
            end

            def issues
                Repo::Issue.find_by(:owner_id, @id)
            end

            def issue_read?(issue_id)
                issue = Repo::Issue.find_by(:id, issue_id)[0]
                read = (issue.owner.username == @username) ? true : false
                issue.collaborators.each do |c|
                    read = true if c.username == @username
                end
                return read
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