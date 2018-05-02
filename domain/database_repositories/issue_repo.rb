module TalkUp

    module Repo

        class Issue
            
            #create
            def self.create(entity)
                db_issue = Database::IssueOrm.create(
                    title_secure: entity.title_secure,
                    description_secure: entity.description_secure,
                    section: entity.section,
                    deadline: entity.deadline
                )

                rebuild_entity(db_issue)
            end
            #read
            def self.all
                Database::IssueOrm.all.map { |db_issue| rebuild_entity(db_issue) }
            end

            def self.find_by(col, value)
                Database::IssueOrm.filter({col => value}).all.map { |db_issue| rebuild_entity(db_issue) }
            end

            #updaet
            def self.update(issue_id, update_info)
                db_record = find_by(id, issue_id)
                if db_record.update(update_info)
                    return rebuild_entity(db_record)
                else
                    return nil
                end
            end

            

            def self.rebuild_entity(db_record)
                return nil unless db_record

                Entity::Issue.new(
                    id: db_record.id,
                    title_secure: db_record.title_secure,
                    description_secure: db_record.description_secure,
                    process: db_record.process,
                    section: db_record.section,
                    deadline: db_record.deadline,
                    comments: db_record.comments,
                    create_time: db_record.created_at,
                    update_time: db_record.updated_at
                )
            end
        end
    end
end