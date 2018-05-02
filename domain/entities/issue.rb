require 'dry-struct'
require_relative './comment.rb'

module TalkUp
    module Entity

        class Issue < Dry::Struct

            attribute :id, Types::Strict::String.optional
            attribute :title_secure, Types::Strict::String
            attribute :description_secure, Types::Strict::String
            attribute :process, Types::Strict::Int.default(1)
            attribute :create_time, Types::Strict::Time.optional
            attribute :update_time, Types::Strict::Time.optional
            attribute :deadline, Types::Strict::Time.optional
            attribute :section, Types::Strict::Int
            
            attribute :comments, Types::Strict::Array.member(Entity::Comment).optional

            def description
                SecureDB.decrypt(description_secure)
            end

            def title
                SecureDB.decrypt(title_secure)
            end
        end 
    end
end