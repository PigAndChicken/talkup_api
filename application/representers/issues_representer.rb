require_relative './issue_representer.rb'

module TalkUp

    class IssuesRepresenter < Roar::Decorator
        include Roar::JSON

        collection :issues, extend: IssueRepresenter
    end
end