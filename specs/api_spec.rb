require_relative './spec_helper.rb'

describe 'Test TalkUp Web API' do
    
    describe 'Root Route' do
        it 'should find the root route' do
            get '/'
            _(last_response.status).must_equal 200
        end
    end
end