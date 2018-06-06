module TalkUp

    class Api < Roda
        
        route('comment') do |routing|  
            
            routing.on 'delete' do
                routing.route('delete', 'comment')
            end

            routing.post do 
                data = JsonRequestBody.parse_sym(routing.body.read)
                data[:username] = @auth_account
                result = CommentService::Create.new.call(data)
                representer_response(result, CommentRepresenter)
            end

        end 
    end
    
end