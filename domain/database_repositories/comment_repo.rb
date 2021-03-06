module TalkUp

    module Repo

        class Comment
            extend Repo
            
            #create
            def self.create_by(account, issue, entity)
                begin
                    comment = Database::CommentOrm.new(entity.to_h)
                    comment.commenter = account
                    comment.issue = issue
                    comment.save
                rescue => exception
                    return { :comment => exception.errors.full_messages }
                end
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
                if comment.save
                    rebuild_entity(comment)
                else
                    nil
                end
            end

            #delete
            def self.delete(comment_id)
                comment = Database::CommentOrm.first(id: comment_id)
                if comment.destroy
                    true
                else
                    false
                end
            end

            def self.rebuild_entity(db_record)
                return nil unless db_record
                elements = rebuild_elements(db_record)

                Entity::Comment.new(
                    id: db_record.id,
                    content: db_record.content,
                    issue_owner: db_record.issue.owner,
                    commenter: elements[:commenter],
                    feedbacks: elements[:feedbacks],
                    anonymous: db_record.anonymous,
                    created_at: db_record.created_at,
                    updated_at: db_record.updated_at
                )
            end
        end
    end
end