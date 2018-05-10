require_relative './spec_helper.rb'

describe 'Test TalkUp Web API' do
  
    describe 'Issue Route' do
        before do
            @req_header = { 'CONTENT_TYPE' => 'application/json' }
            @account = Repo::Account.find_by(:username, DATA[:accounts][0][:username])[0]  
            if @account == nil
                @account = Repo::Account.create(DATA[:accounts][0])
            end
            @vic = Repo::Account.new(@account.username)
        end
    
        describe 'Getting information' do

          it 'HAPPY: should be able to get list of all issues ' do
            issue = @vic.create_issue(DATA[:issues][0])
            get 'api/v0.1/issues'

            result = JSON.parse last_response.body

            _(last_response.status).must_equal 200
            _(result['issues']).must_be_kind_of Array
            _(result['issues'][0].keys).must_include 'title'
         end

         it 'HAPPY: should be able to get details of issue' do
            issue = @vic.create_issue(DATA[:issues][1])

            get "api/v0.1/issue/#{issue.id}"
            result = JSON.parse last_response.body

            _(last_response.status).must_equal 200
            _(result['title']).must_equal issue.title
         end

        end

        describe 'Issue Creation' do 
          it 'HAPPY: should be able to create issue' do
            data = {:username => @account.username, :issue_data => DATA[:issues][1]}
            post "api/v0.1/issue", data.to_json, @req_header
            
            result = JSON.parse last_response.body

            _(last_response.status).must_equal 201
            _(result['title']).must_equal DATA[:issues][1][:title]
            _(result['owner']['username']).must_equal @account.username
          end

          it 'BAD: should be able to return error msg' do 
            post 'api/v0.1/issue', {:username => @account.username,:issue_data=>{:title=>'',:description=>''}}.to_json, @req_header

            result = JSON.parse last_response.body
            _(last_response.status).must_equal 400
            _(result['error'].keys).must_include "issue_errors"
          end

        end

  end
end