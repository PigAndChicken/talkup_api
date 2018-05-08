module TalkUp

    module Database

        class FeedbackDescriptionOrm < Sequel::Model(:feedback_descriptions)
            one_to_many :feedbacks, class: :'TalkUp::Database::FeedbackOrm',
                        key: :description_id

        end
    end
end