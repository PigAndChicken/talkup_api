require_relative './collaborator_representer.rb'

module TalkUp

    class CollaboratorsRepresenter < Roar::Decorator
        include Roar::JSON
        
        collection :collaborators, extend: CollaboratorRepresenter
    end
end