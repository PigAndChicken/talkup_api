require_relative './account_representer.rb'

module TalkUp

    class CollaboratorsRepresenter < Roar::Decorator
        include Roar::JSON
        
        collection :collaborators, extend: AccountRepresenter do 
            property :username
        end
    end
end