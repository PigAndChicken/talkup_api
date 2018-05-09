require 'dry-struct'
require_relative './comment.rb'
require_relative './account.rb'

module TalkUp
    module Entity

        class Issue < Dry::Struct

            attribute :id, Types::Strict::String.optional
            attribute :title, Types::Strict::String
            attribute :description, Types::Strict::String
            attribute :process, Types::Strict::Int.default(1)
            attribute :created_at, Types::Strict::Time.optional
            attribute :updated_at, Types::Strict::Time.optional
            attribute :deadline, Types::Strict::Time.optional
            attribute :section, Types::Strict::Int
            
            attribute :owner, Entity::Account
            attribute :collaborators, Types::Strict::Array.member(Entity::Account).optional
            attribute :comments, Types::Strict::Array.member(Entity::Comment).optional

        end 
    end
end