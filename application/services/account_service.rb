require 'dry-monads'

module TalkUp

    module AccountService 
         extend Dry::Monads::Either::Mixin

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
    end

end