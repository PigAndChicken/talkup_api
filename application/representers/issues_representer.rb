require_relative './issue_representer.rb'
    
module TalkUp

    class IssuesRepresenter < Roar::Decorator
        include Roar::JSON

        collection :issues, extend: IssueRepresenter do 
            property :id
            property :title
            property :deadline
            property :process
            property :section
            property :can_view
        end
    end
end