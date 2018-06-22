
module TalkUp

    class Api < Roda 
        
        route('authenticate', 'accounts') do |routing|

            routing.post 'sso_account' do
                begin
                    access_token = JSON.parse(request.body.read)['access_token']
                    token = SignedRequest.new(Api.config).parse(access_token.to_json)
                    input = {access_token: token, config: Api.config}
                    auth_account = AuthSsoAccount.new.call(input)
                    representer_response(auth_account, AccountRepresenter)
                rescue => e
                    puts e
                    routing.halt '403', { errors: {account: ['Invalid credentials'] } }.to_json
                end
            end

            routing.post 'email_account' do
                    begin 
                        credentials = SignedRequest.new(Api.config).parse(request.body.read)
                        auth_account = AccountService.authenticate(credentials)
                        representer_response(auth_account, AccountRepresenter)
                    rescue
                        routing.halt '403', { errors: {account: ['Invalid credentials'] } }.to_json
                    end
            end
        end
    end
end