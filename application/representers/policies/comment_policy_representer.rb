module TalkUp

    class CommentPolicyRepresenter < Roar::Decorator
        include Roar::JSON

        property :can_edit
        property :can_delete

    end
    
end