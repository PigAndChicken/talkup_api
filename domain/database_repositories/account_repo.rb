require_relative './issue_repo.rb'
require_relative './comment_repo.rb'

module TalkUp

    module Repo

        class Account
            
            def initialize(username, issue_id)
                @account = Database::AccountOrm.first(username: username)
            end

            def add_issue(issue_data)
                Repo::Issue.create_by(@account, issue_data)
            end

            def add_comment(issue_id, comment_data)
                issue = Database::IssueOrm.first(id: issue_id)
                Repo::Comment.create_by(@account, issue, comment_data)
            end

            
            #create
            def self.create(entity)
                db_account = Database::AccountOrm.create(entity.to_h)
                rebuild_entity(db_account)
            end

            #find
            def self.find_by(col, val)
                Database::AccountOrm.filter({col => val}).all.map {|db_record| rebuild_entity(db_record)}
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