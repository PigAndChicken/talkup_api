# require_relative '../test_load_all.rb'

# describe 'Test TalkUp Web API' do 

#     describe 'Comment Route' do 
#         before do
#             @req_header = { 'CONTENT_TYPE' => 'application/json' }
#             @account = Repo::Account.find_by(:username, DATA[:accounts][0][:username])  
#             if @account == nil
#                 @account = Repo::Account.create(DATA[:accounts][0])
#             end
#             @vic = Repo::Account.new(@account.username)
#             @issue = Database::IssueOrm.first
#             if @issue == nil
#                 @issue = @vic.create_issue(DATA[:issues][0])
#             end
#         end
#         after do
#             delete_all
#         end

#         describe 'Comment Creation' do 
#             it 'It should be able to leave a comment' do 
#                 data = {'username' => @account.username, 'issue_id' => @issue.id, 'comment_data' => DATA[:comments][0]}
#                 post 'api/v0.1/comment', data.to_json, @req_header

#                 result = JSON.parse last_response.body
#                 _(last_response.status).must_equal 201
#                 _(result['content']).must_equal DATA[:comments][0][:content]
#                 _(result['commenter']['username']).must_equal @account.username
#             end
#         end

#         describe 'Comment Delete' do 
#             it 'It should be able to delete a comment' do 
#                 data = {'username' => @account.username, 'issue_id' => @issue.id, 'comment_id' => DATA[:comments][0]}
#                 post 'api/v0.1/comment/delete', data.to_json, @req_header
                
#                 result = JSON.parse last_response.body
#                 _(last_response.status).must_equal 200
#             end
#         end

#     end
# end