module TalkUp

    module Database

        class AccountOrm < Sequel::Model(:accounts)
            one_to_many :owned_issues, class: :'TalkUp::Database::IssueOrm',
                        key: :owner_id

            many_to_many :collaborations, class: :'TalkUp::Database::IssueOrm',
                        join_table: :accounts_issues,
                        left_key: :collaborator_id, right_key: :issue_id

            one_to_many :comments, class: :'TalkUp::Database::CommentOrm',
                        key: :commenter_id

            one_to_many :feedbacks, class: :'TalkUp::Database::FeedbackOrm',
                        key: :commenter_id

            plugin :whitelist_security
            set_allowed_columns :username, :email, :password, :type
            plugin :association_dependencies, owned_issues: :destroy, collaborations: :nullify, feedbacks: :destroy, comments: :destroy
            plugin :timestamps, update_on_create: true
            
            plugin :validation_helpers

            def password=(new_password)
                self.salt= SecureDB.new_salt
                self.password_hash = SecureDB.hash_password(salt, new_password)
            end

            def validate
                super
                validates_presence [:username, :email]
                validates_unique :username, :email
            end
        end
    end
end