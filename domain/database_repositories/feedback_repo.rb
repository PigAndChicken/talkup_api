module TalkUp

    module Repo

        class Feedback
            extend Repo

            def self.all_with(col, value)
                Database::FeedbackOrm.where({col=>value}).all.map do |feedback|
                    rebuild_entity(feedback)
                end
            end

            def self.create_by(account, comment, entity)
                description = Database::FeedbackDescriptionOrm.first(entity.to_h)
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
                
                Entity::Feedback.new(
                    id: db_record.id,
                    commenter: element[:commenter],
                    description: db_record.description.description
                )
            end
        end
        
    end
end