require_relative './test_load_all.rb'

describe 'Test TalkUp Web API' do 

    describe 'Feedback Route' do 
        before do

            @req_header = { 'CONTENT_TYPE' => 'application/json' }
            @account = Repo::Account.find_by(:username, DATA[:accounts][0][:username]) 
            if @account == nil
                @account = Repo::Account.create(DATA[:accounts][0])
            end
            @vic = Repo::Account.new(@account.username)
            @issue = Repo::Issue.all[0]
            if @issue == nil
                @issue = @vic.create_issue(DATA[:issues][0])
            end
            @comment = Repo::Comment.find_by(:issue_id, @issue.id)[0]
            if @comment == nil 
                @comment = @vic.add_comment_to(@issue.id, DATA[:comments][0])
            end
        end

        describe 'Feedback Creation' do 
            it 'HAPPY: It should be able to leave a feedback' do 
                data = {'username' => @account.username, 'comment_id' => @comment.id, 'feedback_data' => DATA[:feedbacks][0]}
                
                post 'api/v0.1/feedback', data.to_json, @req_header

                _(last_response.status).must_equal 201
            end
        end

    end
end