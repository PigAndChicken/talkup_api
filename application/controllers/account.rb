

module TalkUp

    class Api < Roda
        
        route('accounts') do |routing|

            routing.post do 
                account_data = JSON.parse routing.body.read
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