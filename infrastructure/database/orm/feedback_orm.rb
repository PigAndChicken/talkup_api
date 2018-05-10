module TalkUp
  module Database
    # Object Relational Mapper for Issue Entities
    class FeedbackOrm < Sequel::Model(:feedbacks)
      many_to_one :issues,
                  class: :'TalkUp::Database::IssueOrm'

      many_to_one :account,
                  class: :'TalkUp::Database::AccountOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
