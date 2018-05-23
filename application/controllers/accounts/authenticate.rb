
module TalkUp

    class Api < Roda 
        
        route('authenticate', 'accounts') do |routing|

            routing.post do
                    begin 
                        credentials = JsonRequestBody.parse_sym(request.body.read)
                        auth_account = AccountService.authenticate(credentials)
                        representer_response(auth_account, AccountRepresenter)
                    rescue
                        routing.halt '403', { errors: {account: 'Invalid credentials' } }.to_json
                    end
            end
        end
    end
end