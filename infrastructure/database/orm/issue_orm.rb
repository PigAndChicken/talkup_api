module TalkUp
  module Database
    # Object Relational Mapper for Issue Entities
    class IssueOrm < Sequel::Model(:issues)

      many_to_one :owner,
                  class: :'TalkUp::Database::AccountOrm'

      many_to_many :collaborators,
                  class: :'TalkUp::Database::AccountOrm',
                  join_table: :accounts_issues,
                  left_key: :issue_id, right_key: :account_id

      one_to_many :comments,
                  class: :'TalkUp::Database::CommentOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
