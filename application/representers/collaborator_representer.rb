
module TalkUp

    class CollaboratorRepresenter < Roar::Decorator
        include Roar::JSON
        
        property :username
    end
end