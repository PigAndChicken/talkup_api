module TalkUp

    class Api < Roda
        
        route('accounts') do |routing|

            routing.on 'authenticate' do 
                routing.route('authenticate', 'accounts')
            end

            routing.post do 
                account_data = JsonRequestBody.parse_sym(request.body.read)
                result = AccountService.create(account_data)
                representer_response(result, AccountRepresenter)
            end

            routing.on String do |username|

                routing.get do 
                    result = AccountService.find(username)
                    representer_response(result, AccountRepresenter)
                end
            end

        end

    end

end