module TalkUp

    class Api < Roda
        
        route('accounts') do |routing|

            routing.on 'authenticate' do 
                routing.route('authenticate', 'accounts')
            end

            routing.post do 
                account_data = SignedRequest.new(Api.config).parse(request.body.read)
                if account_data[:password].nil?
                    account_data[:sendgrid] = Api.config
                    result = EmailVerification.new.call(account_data)    
                    puts result
                    { 'message' => result.value.message }
                else
                    account_data.delete(:confirmed_pwd)
                    account_data.delete(:verification_url)
                    result = AccountService.create(account_data)
                    representer_response(result, AccountRepresenter)
                end
            end

            routing.on String do |username|

                routing.get do 
                    result = AccountService.find(username)
                    representer_response(result, AccountRepresenter)
                end

                routing.delete do 
                    result = AccountService.delete(username)
                    representer_response(result, AccountRepresenter)
                end
            end

        end

    end

end