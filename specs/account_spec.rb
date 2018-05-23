require_relative './spec_helper.rb'

describe 'Test TalkUp Web API' do
    describe 'Accounts Route' do
        before do 
            @req_header = { 'CONTENT_TYPE' => 'application/json' }
        end
        after do 
            delete_all
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

        describe 'Acount authenticate' do 

            it 'HAPPY: should be albe to authenticate account with right password' do
                Repo::Account.create(DATA[:accounts][0])
                post 'api/v0.1/accounts/authenticate', DATA[:accounts][0].to_json, @req_header
                
                result = JSON.parse last_response.body
                _(last_response.status).must_equal 200
                _(result['username']).must_equal DATA[:accounts][0][:username]
            end

            it 'BAD: should be able to render error with error password' do 
                Repo::Account.create(DATA[:accounts][0])
                error_account = DATA[:accounts][0]
                error_account[:password] = 'error'
                post 'api/v0.1/accounts/authenticate', error_account.to_json, @req_header

                _(last_response.status).must_equal 403
            end
        end

        describe 'Account data delete' do 
            
            it 'HAPPY: should be able to delete account' do 
                Repo::Account.create(DATA[:accounts][0])
                delete "api/v0.1/accounts/#{DATA[:accounts][0][:username]}"

                result = JSON.parse last_response.body
                _(last_response.status).must_equal 200
                _(result['username']).must_equal DATA[:accounts][0][:username]
            end

            it 'BAD: should be able to return 404' do 
                delete 'api/v0.1/accounts/wrong_account'
                _(last_response.status).must_equal 404
            end
        end
    end
end