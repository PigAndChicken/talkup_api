module TalkUp
  module Database
    # Object Relational Mapper for Issue Entities
    class CommentOrm < Sequel::Model(:comments)
      many_to_one :issue,
                  class: :'TalkUp::Database::IssueOrm'

      many_to_one :account,
                  class: :'TalkUp::Database::AccountOrm'

      one_to_many :feedbacks,
                  class: :'TalkUp::Database::FeedbackOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
