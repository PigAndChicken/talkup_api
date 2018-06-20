require 'dry-monads'
require 'dry/transaction'
require_relative '../verify_container.rb'

module TalkUp

    module AccountService

        class Collaborators
            include Dry::Transaction
            include Dry::Transaction(container: Container)

            step :current_account, with: "verify.current_account"
            step :find_collaborators

            def find_collaborators(input)
                collaborators = Repo::Account.collaborators(input[:username])
                Right(Result.new(:ok, collaborators))
            end
        end
    end
end