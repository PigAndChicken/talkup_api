module TalkUp

    module Repo

        class Issue
            extend Repo

            #create
            def self.create_by(account, entity)
            
                db_issue = Database::IssueOrm.new(entity)
                db_issue.owner = account
                begin
                    db_issue.save  
                rescue => exception
                    puts exception
                    return { :issue => exception.errors.full_messages }
                end
                  
                rebuild_entity(db_issue)
            end

            def self.add_collaborators(issue_id, collaborators)
                db_issue = Database::IssueOrm.first(id: issue_id)
                
                collaborators.each do |collaborator|
                    db_collaborator = Database::AccountOrm.where(username: collaborator).all[0]
                    db_issue.add_collaborator(db_collaborator)
                end

                rebuild_entity(db_issue)
            end
            
            #read
            def self.all(data)
                Database::IssueOrm.where(data).all.map { |db_issue| rebuild_entity(db_issue) }
            end

            def self.find_by(col, value)
                if col == :collaborator_id
                    issues = Database::IssueOrm.join(Database::AccountIssueOrm.where({col => value}), issue_id: :id).all
                    return issues.map {|db_issue| rebuild_entity(db_issue)}
                end
                Database::IssueOrm.filter({col => value}).all.map { |db_issue| rebuild_entity(db_issue) }
            end

            #updaet
            def self.update(issue_id, update_info)
                db_record = Database::IssueOrm.first(id: issue_id)
                if db_record.update(update_info)
                    return rebuild_entity(db_record)
                else
                    return nil
                end
            end
            
            #delete
            def self.delete(issue_id)
                db_issue = Database::IssueOrm.first(id: issue_id)
                
                if db_issue == nil
                    return nil
                else
                    rebuild_entity(db_issue.destroy)
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
                    anonymous: db_record.anonymous,
                    owner: elements[:owner],
                    comments: elements[:comments],
                    collaborators: elements[:collaborators],
                    created_at: db_record.created_at,
                    updated_at: db_record.updated_at
                )
            end
        end
    end
end