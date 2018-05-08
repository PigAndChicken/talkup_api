require 'dry-struct'
require_relative './account.rb'

module TalkUp
    module Entity
        class Feedback < Dry::Struct
            
            attribute :id, Types::Strict::Int
            attribute :commenter, Entity::Account
            attribute :description, Types::Strict::String

        end 
    end
end