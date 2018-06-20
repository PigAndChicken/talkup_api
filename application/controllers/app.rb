require 'roda'

module TalkUp

    class Api < Roda 
        plugin :json
        plugin :multi_route
        plugin :halt
        plugin :all_verbs
        plugin :request_headers


        def authenticated_account(headers)
            return nil unless headers['AUTHORIZATION']
            scheme, auth_token = headers['AUTHORIZATION'].split(' ')
            account_payload = AuthToken.payload(auth_token)
            scheme.match(/^Bearer/i) ? account_payload : nil
        end
        
        def secure_request?(routing)
            routing.scheme.casecmp(Api.config.SECURE_SCHEME).zero?
        end
 
        route do |routing|
            # @auth_account = authenticated_account( routing.headers )
            @auth_account = Repo::Account.find_by(:username, authenticated_account( routing.headers ))
            response['Content_Type'] = 'application/json'
            secure_request?(routing) || routing.halt(403, {message: 'TLS/SSL Requested'}.to_json)
            app = Api
            
            routing.root do 
                { 'message' => "TalkUp API v0.1 up in #{app.environment}" }
            end
            
            # /api 
            routing.on 'api' do
                # /api/v0.1
                routing.on 'v0.1' do

                    routing.multi_route
                end
            end
        end
    end

end