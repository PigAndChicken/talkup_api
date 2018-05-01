module TalkUp

    module Database

        class CommentOrm < Sequel::Model(:comments)
            many_to_one :issue,
                        class: :'TalkUp::Database::IssueOrm'
            
            plugin :timestamps, update_on_create: true
            plugin :uuid, field: :id
        end
    end
end