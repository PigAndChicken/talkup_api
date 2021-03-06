require_relative './issue_repo.rb'
require_relative './comment_repo.rb'

module TalkUp

    module Repo

        class Account
            
            def initialize(username)
                @account = Database::AccountOrm.first(username: username)
            end
            
            #user behavior
            def create_issue(issue_data)
                Repo::Issue.create_by(@account, issue_data)
            end

            def add_collaborators_to(issue_id, collaborators)
                issue = Repo::Issue.add_collaborators(issue_id, collaborators)
                return nil if issue.nil?
                puts collaborators
                issue.collaborators.select {|c| collaborators.include?(c.username)}
            end

            def remove_collaborator(issue_id, collaborator)
                collaborator = Repo::Issue.remove_collaborator(issue_id, collaborator)
                return nil if collaborator.nil?
                Account.rebuild_entity(collaborator)
            end

            def add_comment_to(issue_id, comment_data)
                issue = Database::IssueOrm.first(id: issue_id)
                Repo::Comment.create_by(@account, issue, comment_data)
            end

            def add_feedback_to(comment_id, feedback_data)
                comment = Database::CommentOrm.first(id: comment_id)
                Repo::Feedback.create_by(@account, comment, feedback_data)
            end
            
            #create
            def self.create(entity)
                begin
                    db_account = Database::AccountOrm.create(entity.to_h)    
                rescue => exception
                    return { :account => exception.errors.full_messages }
                end
                rebuild_entity(db_account)
            end

            def self.collaborators(username)
                collaborators = Database::AccountOrm.all.delete_if {|item| item.username == username}
                collaborators.map {|c| rebuild_entity(c)}
            end

            #find
            def self.find_by(col, val)
                rebuild_entity( Database::AccountOrm.filter({col => val}).first )
            end

            #delete
            def self.delete(account_username)
                db_account = Database::AccountOrm.first(username: account_username)
                
                if db_account == nil
                    return nil
                else
                    rebuild_entity(db_account.destroy)
                end
            end

            def self.rebuild_entity(db_record)
                return nil unless db_record
                if db_record.type == 'email'
                    Entity::EmailAccount.new(
                        id: db_record.id,
                        username: db_record.username,
                        email: db_record.email,
                        password_hash: db_record.password_hash,
                        salt: db_record.salt,
                        type: db_record.type
                    )
                else
                    Entity::SsoAccount.new(
                        id: db_record.id,
                        username: db_record.username,
                        email: db_record.email,
                        type: db_record.type
                    )
                end
            end
        end
    end
end