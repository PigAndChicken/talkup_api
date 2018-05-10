

module TalkUp

    class IssueRepresenter < Roar::Decorator
        include Roar::JSON

        property :title
        property :description
        property :deadline
        property :process
        property :section

        property :owner, extend: AccountRepresenter
        collection :collaborators, extend: AccountRepresenter
        collection :comments, extend: CommentRepresenter

    end
end