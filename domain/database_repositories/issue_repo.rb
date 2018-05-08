module TalkUp

    module Repo

        class Issue
            extend Repo
            


            #create
            def self.create_by(account, entity)
                db_issue = Database::IssueOrm.create(entity.to_h)

                db_issue.owner = account
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
                elements = rebuild_elements(db_record)

                Entity::Issue.new(
                    id: db_record.id,
                    title: db_record.title,
                    description: db_record.description,
                    process: db_record.process,
                    section: db_record.section,
                    deadline: db_record.deadline,
                    owner: elements[:owner],
                    comments: elements[:comments],
                    created_at: db_record.created_at,
                    updated_at: db_record.updated_at
                )
            end
        end
    end
end