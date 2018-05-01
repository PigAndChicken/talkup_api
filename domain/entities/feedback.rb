require 'base64'
require 'json'
require 'rbnacl/libsodium'
require 'dry-struct'

module TalkUp
    module Entity

        class Feedback < Dry::Struct
            
            attribute :id, Types::Strict::Int
            attribute :description, Types::Strict::String

        end 
    end
end