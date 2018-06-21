
require 'dry-struct'
require_relative './comment.rb'
require_relative './account.rb'
require_relative './feedback_description.rb'

module TalkUp
    module Entity

        class Issue < Dry::Struct

            attribute :id, Types::Strict::String.optional
            attribute :title, Types::Strict::String
            attribute :description, Types::Strict::String
            attribute :process, Types::Strict::Int.default(1)
            attribute :created_at, Types::Strict::Time.optional
            attribute :updated_at, Types::Strict::Time.optional
            attribute :deadline, Types::Strict::Time.optional
            attribute :section, Types::Strict::Int
            attribute :anonymous, Types::Strict::Int
            
            attribute :owner, Entity::Account
            attribute :collaborators, Types::Strict::Array.member(Entity::Account).optional
            attribute :comments, Types::Strict::Array.member(Entity::Comment).optional
            attribute :feedback_description, Types::Strict::Array.member(Entity::FeedbackDescription)

            def set_policy(account)
                policy = IssuePolicy.new(account, Repo::Issue.find_by(:id, @id)[0])
                @policy = policy
            end

            def policy
                return 'please set policy' unless @policy
                    
                OpenStruct.new(@policy.summary)
            end

            def can_view
                @policy.can_view?
            end

        end 
    end
end