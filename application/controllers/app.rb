require 'roda'

module TalkUp

    class Api < Roda 
        plugin :json
        plugin :multi_route

        require_relative './issue.rb'        

        route do |routing|
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