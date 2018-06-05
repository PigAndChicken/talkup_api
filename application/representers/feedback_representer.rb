require_relative './account_representer.rb'

module TalkUp

    class FeedbackRepresenter < Roar::Decorator
        include Roar::JSON

        property :description
        property :commenter , extend: AccountRepresenter do
            property :username
        end
    end
end