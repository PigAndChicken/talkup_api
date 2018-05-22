require_relative './spec_helper.rb'


DATA[:feedbacks].each do |feedback|
    TalkUp::Database::FeedbackDescriptionOrm.create(feedback.to_h)
end

describe 'Test all Repo' do 

    before do
        vic = TalkUp::Repo::Account.find_by(:username, DATA[:accounts][0][:username])
        shelly = TalkUp::Repo::Account.find_by(:username, DATA[:accounts][1][:username])
        Repo::Account.create(DATA[:accounts][0]) if vic == nil
        Repo::Account.create(DATA[:accounts][1]) if shelly == nil
    end

    describe 'Store all information' do

        it 'HAPPY: should be able to store account with correct information' do
            vic = TalkUp::Repo::Account.find_by(:username, DATA[:accounts][0][:username])
            shelly = TalkUp::Repo::Account.find_by(:username, DATA[:accounts][1][:username])

            _(vic).must_be_instance_of TalkUp::Entity::Account
            _(shelly.username).must_equal DATA[:accounts][1][:username]
        end

        it 'HAPPY: should be able to store other data with account object' do
            vic = TalkUp::Repo::Account.new(DATA[:accounts][0][:username])
            shelly = TalkUp::Repo::Account.find_by(:username, DATA[:accounts][1][:username])

            issue = vic.create_issue(DATA[:issues][0])
            _(issue).must_be_instance_of TalkUp::Entity::Issue
            _(issue.title).must_equal DATA[:issues][0][:title]
            
            issue = vic.add_collaborators_to(issue.id, [{:email => shelly.email}])
            _(issue.collaborators[0]).must_be_instance_of TalkUp::Entity::Account
            
            comment = vic.add_comment_to(issue.id, DATA[:comments][0])
            _(comment).must_be_instance_of TalkUp::Entity::Comment
            _(comment.commenter.username).must_equal DATA[:accounts][0][:username]

            feedback = vic.add_feedback_to(comment.id, DATA[:feedbacks][0])
            _(feedback).must_be_instance_of TalkUp::Entity::Feedback
            _(feedback.description).must_equal DATA[:feedbacks][0][:description]
        end
    end

    describe 'Correct Dependencies and Delete Data' do 
        
        before do 
            @account = Repo::Account.find_by(:username, DATA[:accounts][2][:username])
            @account = TalkUp::Repo::Account.create(DATA[:accounts][2]) if @account == nil
            soumya = TalkUp::Repo::Account.new(DATA[:accounts][2][:username])
            @issue = soumya.create_issue(DATA[:issues][1])
            @comment = soumya.add_comment_to(@issue.id, DATA[:comments][1])
            @feedback = soumya.add_feedback_to(@comment.id, DATA[:feedbacks][1])
        end

        it 'HAPPY: Dependency between comment and feedback' do 
            Repo::Comment.delete(@comment.id)
            comment = TalkUp::Repo::Comment.find_by(:id, @comment.id)[0]
            feedback = TalkUp::Repo::Feedback.all_with(:id, @feedback.id)[0]
            _(comment).must_be_nil
            _(feedback).must_be_nil
        end

        it 'HAPPY: Dependency between issue and comment' do 
            Repo::Issue.delete(@issue.id)
            issue = Repo::Issue.find_by(:id, @issue.id)[0]
            comment = Repo::Comment.find_by(:id, @comment.id)[0]
            _(issue).must_be_nil
            _(comment).must_be_nil   
        end

        it 'HAPPY: Dependecy between account and issue' do
            Repo::Account.delete(@account.username)
            account = Repo::Account.find_by(:username, @account.username)
            issue = Repo::Issue.find_by(:id, @issue.id)[0]
            _(account).must_be_nil
            _(issue).must_be_nil
        end

    end
end