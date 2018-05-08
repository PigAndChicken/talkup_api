require_relative './spec_helper.rb'

describe 'Test Issue Route' do
    include Rack::Test::Methods
    
    describe 'Getting information' do
        
        before do

        end

        it 'HAPPY: should be able to get list of all index of issues' do
        
            get 'api/v0.1/issues'
            result = JSON.parse last_response.body

            _(last_response.status).must_equal 200
            _(result['issues'][0]['id']).must_be_kind_of String
        end

        it 'HAPPY: should be able to get details of issue' do

            get "api/v0.1/issue/#{ISSUE.id}"
            
            result = JSON.parse last_response.body
            _(last_response.status).must_equal 200
            _(result['title']).must_equal ISSUE.title
        end

    end

end