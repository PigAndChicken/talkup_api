require_relative './account_representer.rb'
require_relative './feedback_representer.rb'
require_relative './policies/comment_policy_representer.rb'

module TalkUp

    class CommentRepresenter < Roar::Decorator
        include Roar::JSON

        property :id
        property :content
        property :policy, extend: CommentPolicyRepresenter
        property :commenter , extend: AccountRepresenter do
            property :username
        end
        property :issue_owner, extend: AccountRepresenter do 
            property :username
        end
        collection :feedbacks, extend: FeedbackRepresenter do
            property :description
        end
    end
end