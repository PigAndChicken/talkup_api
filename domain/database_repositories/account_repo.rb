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
                Repo::Issue.add_collaborators(issue_id, collaborators)
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
                    return { :account_errors => exception.errors.to_h }
                end
                rebuild_entity(db_account)
            end

            #find
            def self.find_by(col, val)
                Database::AccountOrm.filter({col => val}).all.map {|db_record| rebuild_entity(db_record)}
            end

            #delete
            def self.delete(account_username)
                db_account = Database::AccountOrm.first(username: account_username)
                
                if db_account == nil
                    return nil
                else
                    db_account.destroy
                end
            end

            def self.rebuild_entity(db_record)
                return nil unless db_record
                Entity::Account.new(
                    id: db_record.id,
                    username: db_record.username,
                    email: db_record.email,
                )
            end
        end
    end
end