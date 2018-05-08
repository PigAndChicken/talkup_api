module TalkUp

    module Database

        class FeedbackOrm < Sequel::Model(:feedbacks)
            many_to_one :description, class: :'TalkUp::Database::FeedbackDescriptionOrm'
                        
            many_to_one :account, class: :'TalkUp::Database::AccountOrm'
            many_to_one :comment, class: :'TalkUp::Database::CommentOrm'
        end
    end
end