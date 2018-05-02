require_relative './spec_helper.rb'

describe 'Test Issue Route' do
    include Rack::Test::Methods
    
    describe 'Getting information' do
        
        before do
            issue_entity = TalkUp::Entity::Issue.new(ISSUE_ONE)
            @issue = TalkUp::Repo::Issue.create(issue_entity)
        end

        it 'HAPPY: should be able to get list of all index of issues' do
        
            get 'api/v0.1/issues'
            result = JSON.parse last_response.body

            _(last_response.status).must_equal 200
            _(result['issues'][0]['id']).must_be_kind_of String
        end

        it 'HAPPY: should be able to get details of issue' do

            get "api/v0.1/issue/#{@issue.id}"
            result = JSON.parse last_response.body

            _(last_response.status).must_equal 200
            _(result['title']).must_equal @issue.title
        end

    end

end