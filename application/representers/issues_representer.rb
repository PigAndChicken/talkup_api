require_relative './issue_representer.rb'

module TalkUp

    class IssuesRepresenter < Roar::Decorator
        include Roar::JSON

        collection :issues, class: IssueRepresenter do 
            property :id
            property :title
            #property :description
            property :deadline
            property :process
            property :section

            property :owner, extend: AccountRepresenter
        end
    end
end