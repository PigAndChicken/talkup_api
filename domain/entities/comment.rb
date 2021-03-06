require 'dry-struct'

require_relative './account.rb'
require_relative './feedback.rb'

module TalkUp
    module Entity

        class Comment < Dry::Struct
            
            attribute :id, Types::Strict::String
            attribute :content, Types::Strict::String
            attribute :created_at, Types::Strict::Time.optional
            attribute :updated_at, Types::Strict::Time.optional
            attribute :anonymous, Types::Strict::Int

            attribute :issue_owner, Entity::Account
            attribute :commenter, Entity::Account
            attribute :feedbacks, Types::Strict::Array.member(Entity::Feedback).optional

            def set_policy(account)
                policy = CommentPolicy.new(account, Repo::Comment.find_by(:id, @id)[0])
                @policy = policy
            end

            def policy
                return 'please set policy' unless @policy
                
                OpenStruct.new @policy.summary
            end

            def issue
                comment = TalkUp::Database::CommentOrm.first(id: @id) 
                Repo::Issue.find_by(:id, comment.issue.id)[0]
            end

        end 
    end
end