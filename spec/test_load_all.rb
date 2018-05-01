
require_relative '../init.rb'

def encode(content)
    Base64.strict_encode64(content)
end

FEEDBACK_INFO1 = {
    :id => 1,
    :description => 'like'
}
FEEDBACK_INFO2 = {
    :id => 2,
    :description => 'confusing'
}

FEEDBACK_like = TalkUp::Entity::Feedback.new(FEEDBACK_INFO1)
FEEDBACK_confusing = TalkUp::Entity::Feedback.new(FEEDBACK_INFO2)

COMMENT_INFO = {
    :content => 'I like this!',
    :create_time => nil,
    :update_time => nil,
    :feedback => [FEEDBACK_like]

}

COMMENT_INFO2 = {
    :content => 'I dont agree this!',
    :create_time => nil,
    :update_time => nil,
    :feedback => [FEEDBACK_confusing]
}

COMMENT = TalkUp::Entity::Comment.new(COMMENT_INFO)
COMMENT2 = TalkUp::Entity::Comment.new(COMMENT_INFO2)

COMMENTS = [COMMENT, COMMENT2]
DESCRIPTION = encode('testing')
ISSUE_INFO = {
    :title => 'issue_one',
    :description_secure => DESCRIPTION,
    :process => 1,
    :create_time => nil,
    :update_time => nil,
    :deadline => nil,
    :section => 2,
    :comments => COMMENTS
}


