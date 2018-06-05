require_relative './account_representer.rb'
require_relative './feedback_representer.rb'

module TalkUp

    class CommentRepresenter < Roar::Decorator
        include Roar::JSON

        property :id
        property :content
        property :commenter , extend: AccountRepresenter do
            property :username
        end
        property :issue_owner, extend: AccountRepresenter do 
            property :username
        end
        collection :feedbacks, extend: FeedbackRepresenter
    end
end