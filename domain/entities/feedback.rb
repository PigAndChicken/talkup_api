require 'dry-struct'
require_relative './account.rb'
require_relative './feedback_description.rb'

module TalkUp
    module Entity
        class Feedback < FeedbackDescription
            
            attribute :id, Types::Strict::Int
            attribute :commenter, Entity::Account
        end 
    end
end