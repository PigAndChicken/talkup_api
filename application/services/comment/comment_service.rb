require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module CommentService
         extend Dry::Monads::Either::Mixin
    end
end