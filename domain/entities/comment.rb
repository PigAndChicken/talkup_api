require 'dry-struct'

require_relative './account.rb'
require_relative './feedback.rb'

module TalkUp
    module Entity

        class Comment < Dry::Struct
            
            attribute :id, Types::Strict::String
            attribute :content, Types::Strict::String
            attribute :created_at, Types::Strict::Time.optional
            attribute :updated_at, Types::Strict::Time.optional

            attribute :commenter, Entity::Account.optional
            attribute :feedbacks, Types::Strict::Array.member(Entity::Feedback)

        end 
    end
end