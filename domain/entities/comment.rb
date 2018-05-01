require 'base64'
require 'json'
require 'rbnacl/libsodium'
require 'dry-struct'

require_relative './feedback.rb'

module TalkUp
    module Entity

        class Comment < Dry::Struct
            
            attribute :content, Types::Strict::String
            attribute :create_time, Types::Strict::DateTime.optional
            attribute :update_time, Types::Strict::DateTime.optional

            attribute :feedback, Types::Strict::Array.member(Entity::Feedback)


        end 
    end
end