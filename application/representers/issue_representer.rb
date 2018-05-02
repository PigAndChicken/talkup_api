module TalkUp

    class IssueRepresenter < Roar::Decorator
        include Roar::Json

        property :id
    end
end