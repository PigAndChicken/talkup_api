
module TalkUp

    class AccountRepresenter < Roar::Decorator
        include Roar::JSON
        
        property :username
        property :email
        property :token

        collection :issues
    end
end