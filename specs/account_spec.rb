require_relative './spec_helper.rb'

describe 'Test TalkUp Web API' do
    
    describe 'Accounts Route' do
        before do 
            @req_header = { 'CONTENT_TYPE' => 'application/json' }
            accounts = Database::AccountOrm.all
            if !accounts.empty?
                accounts.each { |a| a.destroy }
            end
        end
        after do 
            accounts = Database::AccountOrm.all
            if !accounts.empty?
                accounts.each { |a| a.destroy }
            end
        end

        describe 'Account Creation' do
            
            it 'HAPPY: should be able to create a account' do
                post 'api/v0.1/accounts', DATA[:accounts][0].to_json, @req_header
                
                result = JSON.parse last_response.body

                _(last_response.status).must_equal 201 
                _(result['username']).must_equal DATA[:accounts][0][:username]
            end

            it 'BAD: should be able to return error msg' do 
                post 'api/v0.1/accounts', DATA[:accounts][0].to_json, @req_header
                post 'api/v0.1/accounts', DATA[:accounts][0].to_json, @req_header

                result = JSON.parse last_response.body
                
                _(last_response.status).must_equal 400
                _(result['error'].keys).must_include "account_errors"
            end
        end

        describe 'Account Details' do 

            it 'HAPPY: should be able to get details of account' do 
                Repo::Account.create(DATA[:accounts][0])
                get "api/v0.1/accounts/#{DATA[:accounts][0][:username]}"
                
                result = JSON.parse last_response.body
                _(last_response.status).must_equal 200
                _(result['username']).must_equal DATA[:accounts][0][:username]
            end

            it 'BAD: should be able to return not found msg' do 
                get 'api/v0.1/accounts/nobody'

                result = JSON.parse last_response.body
                _(last_response.status).must_equal 404
                _(result.keys).must_include "error"
            end
        end
    end
end