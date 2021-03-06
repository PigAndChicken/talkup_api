

module TalkUp

    module Repo

        class Feedback
            extend Repo

            def self.all_with(col, value)
                Database::FeedbackOrm.where({col=>value}).all.map do |feedback|
                    rebuild_entity(feedback)
                end
            end

            def self.all_description
                Database::FeedbackDescriptionOrm.all.map do |feedback_description|
                    Entity::FeedbackDescription.new(
                        description: feedback_description.description
                    )
                end
            end

            def self.create_by(account, comment, feedback)
                description = Database::FeedbackDescriptionOrm.first(feedback)
                feedback = Database::FeedbackOrm.new
                feedback.commenter= account
                feedback.comment= comment
                feedback.description= description
                feedback.save

                rebuild_entity(feedback)
            end
            
            def self.rebuild_entity(db_record)
                return nil unless  db_record
                element = rebuild_elements(db_record)    
                #return nil if db_record.description.nil?
                Entity::Feedback.new(
                    id: db_record.id,
                    commenter: element[:commenter],
                    description: db_record.description.description
                )
            end
        end
        
    end
end