module TalkUp

    module Database

        class IssueOrm < Sequel::Model(:issues)
            one_to_many :comments,
                        class: :'TalkUp::Database::CommentOrm',
                        key: :issue_id

            plugin :timestamps, update_on_create: true
            plugin :uuid, field: :id
        end
    end
end