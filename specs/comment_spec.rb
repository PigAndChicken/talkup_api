require_relative './test_load_all.rb'

describe 'Test TalkUp Web API' do 

    describe 'Comment Route' do 
        before do
            @req_header = { 'CONTENT_TYPE' => 'application/json' }
            @account = Repo::Account.find_by(:username, DATA[:accounts][0][:username])[0]  
            if @account == nil
                @account = Repo::Account.create(DATA[:accounts][0])
            end
            @vic = Repo::Account.new(@account.username)
        end
        
        

    end
end