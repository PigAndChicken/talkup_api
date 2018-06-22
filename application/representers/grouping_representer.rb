require_relative './comment_representer.rb'

module TalkUp

    class GroupingRepresenter < Roar::Decorator
        include Roar::JSON

        collection :like_comments, extend: CommentRepresenter do
            property :content
            collection :feedbacks, extend: FeedbackRepresenter do
                property :description
            end
        end
        collection :dislike_comments, extend: CommentRepresenter do
            property :content
            collection :feedbacks, extend: FeedbackRepresenter do
                property :description
            end
        end
        collection :confusing_comments, extend: CommentRepresenter do
            property :content
            collection :feedbacks, extend: FeedbackRepresenter do
                property :description
            end
        end
        collection :interesting_comments, extend: CommentRepresenter do
            property :content
            collection :feedbacks, extend: FeedbackRepresenter do
                property :description
            end
        end

    end
end