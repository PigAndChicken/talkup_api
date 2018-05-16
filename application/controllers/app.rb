require 'roda'

module TalkUp

    class Api < Roda 
        plugin :json
        plugin :multi_route
        plugin :halt
        plugin :all_verbs
        
        def secure_request?(routing)
            routing.scheme.casecmp(Api.config.SECURE_SCHEME).zero?
        end

        route do |routing|
            response    ['Content_Type'] = 'application/json'
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