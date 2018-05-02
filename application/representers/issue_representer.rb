module TalkUp

    class IssueRepresenter < Roar::Decorator
        include Roar::JSON

        property :title
        property :description
        property :deadline
        property :process
        property :section
    end
end