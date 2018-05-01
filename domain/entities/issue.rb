require 'dry-struct'
require_relative './comment.rb'

module TalkUp
    module Entity

        class Issue < Dry::Struct

            attribute :title, Types::Strict::String
            attribute :description_secure, Types::Strict::String
            attribute :process, Types::Strict::Int
            attribute :create_time, Types::Strict::DateTime.optional
            attribute :update_time, Types::Strict::DateTime.optional
            attribute :deadline, Types::Strict::DateTime.optional
            attribute :section, Types::Strict::Int
            
            attribute :comments, Types::Strict::Array.member(Entity::Comment)

            def description
                decode(description_secure)
            end

            private


            def decode(encoded_content)
                Base64.strict_decode64(encoded_content)
            end
        end 
    end
end