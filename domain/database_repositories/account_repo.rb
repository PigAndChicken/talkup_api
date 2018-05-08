require_relative './issue_repo.rb'

module TalkUp

    module Repo

        class Account
            extend Repo

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
                    username: db_record.username,
                    email: db_record.email,
                )
            end
        end
    end
end