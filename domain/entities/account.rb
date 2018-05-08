require 'dry-struct'

module TalkUp

    module Entity
        
        class Account < Dry::Struct

            attribute :username, Types::Strict::String
            attribute :email, Types::Strict::String
        end
    end
end