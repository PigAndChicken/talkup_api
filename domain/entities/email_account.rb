require_relative './account.rb'

module TalkUp

    module Entity
        
        class EmailAccount < Account
            
            attribute :password_hash, Types::Strict::String
            attribute :salt, Types::Strict::String


            def password?(try_password)
                try_hash = SecureDB.hash_password(@salt, try_password)
                try_hash == @password_hash
            end
        end
    end
end