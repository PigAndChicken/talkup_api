module TalkUp

    module Database

        class IssueOrm < Sequel::Model(:issues)

            many_to_one :owner, class: :'TalkUp::Database::AccountOrm'

            many_to_many :collaborators, class: :'TalkUp::Database::AccountOrm',
                        join_table: :accounts_issues,
                        left_key: :issue_id, right_key: :collaborator_id

            one_to_many :comments,
                        class: :'TalkUp::Database::CommentOrm',
                        key: :issue_id


            
            plugin :whitelist_security
            set_allowed_columns :title, :description, :section, :process, :deadline
            plugin :association_dependencies, comments: :destroy, collaborators: :nullify
            plugin :timestamps, update_on_create: true
            plugin :uuid, field: :id

            def title=(title)
                self.title_secure = SecureDB.encrypt(title)
            end

            def description=(description)
                self.description_secure = SecureDB.encrypt(description)
            end

            def title
                SecureDB.decrypt(title_secure)
            end

            def description
                SecureDB.decrypt(description_secure)
            end
        end
    end
end