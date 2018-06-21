require 'dry-struct'

module TalkUp
    module Entity
        class FeedbackDescription < Dry::Struct
            
            attribute :description, Types::Strict::String
        end 
    end
end