module TalkUp

    class IssuePolicyRepresenter < Roar::Decorator
        include Roar::JSON

        property :can_view
        property :can_comment
        property :can_comment_anonymously
        property :can_edit
        property :can_delete
        property :can_add_collaborators
        property :can_remove_collaborators
        property :can_leave
        collection :comments
    end
    
end