module TalkUp

    module Database

        class CommentOrm < Sequel::Model(:comments)
            many_to_one :commenter,
                        class: :'TalkUp::Database::AccountOrm'
            many_to_one :issue,
                        class: :'TalkUp::Database::IssueOrm'

            one_to_many :feedbacks, class: :'TalkUp::Database::FeedbackOrm',
                        key: :comment_id

            plugin :whitelist_security
            set_allowed_columns :content
            plugin :association_dependencies, feedbacks: :destroy
            plugin :timestamps, update_on_create: true
            plugin :uuid, field: :id

            plugin :validation_helpers

            def content=(content)
                self.content_secure = SecureDB.encrypt(content)
            end

            def content
                SecureDB.decrypt(content_secure)
            end

            def validate
                super
                validates_presence [:content]
            end
        end
    end
end