
module TalkUp

    class Api < Roda 
        
        route('authenticate', 'accounts') do |routing|

            routing.post 'sso_account' do
                begin 
                    token = JsonRequestBody.parse_sym(request.body.read)
                    input = {access_token: token[:access_token], config: Api.config}
                    puts input
                    auth_account = AuthSsoAccount.new.call(input)
                    representer_response(auth_account, AccountRepresenter)
                rescue
                    routing.halt '403', { errors: {account: ['Invalid credentials'] } }.to_json
                end
            end

            routing.post 'email_account' do
                    begin 
                        credentials = JsonRequestBody.parse_sym(request.body.read)
                        auth_account = AccountService.authenticate(credentials)
                        representer_response(auth_account, AccountRepresenter)
                    rescue
                        routing.halt '403', { errors: {account: ['Invalid credentials'] } }.to_json
                    end
            end
        end
    end
end