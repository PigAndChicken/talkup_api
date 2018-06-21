require_relative './account_representer.rb'
require_relative './comment_representer.rb'
require_relative './feedback_representer.rb'
require_relative './policies/issue_policy_representer.rb'

module TalkUp

    class IssueRepresenter < Roar::Decorator
        include Roar::JSON

        property :id
        property :title
        property :anonymous
        property :description
        property :deadline
        property :process
        property :section
        property :policy, extend: IssuePolicyRepresenter 
        property :owner, extend: AccountRepresenter do
            property :username
        end
        collection :collaborators, extend: AccountRepresenter do
            property :username
        end
        collection :feedback_description, extend: FeedbackRepresenter do
            property :description
        end
        collection :comments, extend: CommentRepresenter

    end
end