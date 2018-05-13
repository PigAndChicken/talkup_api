require 'dry-monads'

module TalkUp

    module AccountService 
        extend Dry::Monads::Either::Mixin

        class UnauthorizedError < StandardError
            def initialize(msg = nil)
                @credentials = msg
            end

            def message
                "Invalid Credentials for: #{@credentials[:username]}"
            end
        end

        def self.create(input) 
            result = Repo::Account.create(input)
            if result.class == Hash 
                Left(Result.new(:bad_request, result))
            else
                Right(Result.new(:created, result))
            end
        end

        def self.find(input)
            result = Repo::Account.find_by(:username, input)[0]
            if result == nil 
                Left(Result.new(:not_found, 'Could not find any.'))
            else
                Right(Result.new(:ok, result))
            end
        end

        def self.authenticate(input)
            begin
                account = Repo::Account.find_by(:username, input[:username])[0]
                account.password?(input[:password]) ? Right(Result.new(:ok, account)) : raise
            rescue UnauthorizedError
                raise UnauthorizedError, input                
            end
        end
    end

end