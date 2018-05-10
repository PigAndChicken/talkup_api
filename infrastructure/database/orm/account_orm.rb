module TalkUp
  module Database
    class AccountOrm < Sequel::Model(:accounts)
      one_to_many :issues,
                  class: :'TalkUp::Database::IssueOrm'

      many_to_many :issues,
                   class: :'TalkUp::Database::IssueOrm',
                   join_table: :accounts_issues,
                   left_key: :collaborator_id, right_key: :issue_id

      one_to_many :comments,
                  class: :'TalkUp::Database::CommentOrm'

      one_to_many :feedbacks,
                  class: :'TalkUp::Database::FeedbackOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
