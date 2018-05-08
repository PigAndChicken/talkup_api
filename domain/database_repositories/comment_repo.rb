module TalkUp

    module Repo

        class Comment
            extend Repo
            
            #create
            def self.create_by(username, issue_id, entity)
                account = Database::AccountOrm.first(username: username)
                issue = Database::IssueOrm.first(id: issue_id)
                
                comment = Database::CommentOrm.new(entity.to_h)
                comment.commenter = account
                comment.issue = issue
                comment.save

                rebuild_entity(comment)
            end

            #update
            def self.update(issue_id, comment_id,, entity)
                issue = Database::IssueOrm.first(id: issue_id)
                comment = Database::CommentOrm.first(id: comment_id)
                
                comment.update(entity.to_h)
                comment.issue = issue
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
                    content: db_record.content,
                    commenter: elements[:commenter],
                    created_at: db_record.created_at,
                    updated_at: db_record.updated_at
                )
            end
        end
    end
end