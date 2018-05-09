require_relative './account_representer.rb'

module TalkUp

    class CommentRepresenter < Roar::Decorator
        include Roar::JSON

        property :id
        property :content
        property :commenter , extend: AccountRepresenter
    end
end