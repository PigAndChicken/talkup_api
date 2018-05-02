module TalkUp

    class IssuesRepresenter < Roar::Decorator
        include Roar::Json

        collection :issues, extend: IssueRepresenter
    end
end