module TalkUp

    module Repo

        class Comment
            extend Repo
            
            #create
            def self.create_by(account, issue, entity)
                comment = Database::CommentOrm.new(entity.to_h)
                comment.commenter = account
                comment.issue = issue
                comment.save

                rebuild_entity(comment)
            end

            #read
            def self.find_by(col, value)
                Database::CommentOrm.where({col => value}).all.map do |comment|
                    rebuild_entity(comment)
                end
            end

            #update
            def self.update(comment_id, entity)
                comment = Database::CommentOrm.first(id: comment_id)
                comment.update(entity.to_h)
                comment.save
            end

            #delete
            def self.delete(comment_id)
                comment = Database::CommentOrm.first(id: comment_id)
                comment.destroy
            end

            def self.rebuild_entity(db_record)
                return nil unless db_record
                elements = rebuild_elements(db_record)

                Entity::Comment.new(
                    id: db_record.id,
                    content: db_record.content,
                    commenter: elements[:commenter],
                    feedbacks: elements[:feedbacks],
                    created_at: db_record.created_at,
                    updated_at: db_record.updated_at
                )
            end
        end
    end
end