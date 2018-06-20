module TalkUp

    class Api < Roda

        route('collaborators') do |routing|
                
                routing.get do 
                    result = AccountService::Collaborators.new.call({username: @auth_account.username})
                    representer_response(result, CollaboratorsRepresenter) { Collaborators.new(result.value.message) }
                end
        end
    end
end