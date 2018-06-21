module TalkUp

    class Api < Roda
        
        route('comment') do |routing|  
            
            routing.on 'delete' do
                routing.route('delete', 'comment')
            end
            
            routing.on 'feedback' do 
                routing.route('feedback', 'comment')
            end

            routing.post do 
                data = JsonRequestBody.parse_sym(routing.body.read)
                data[:username] = @auth_account.username
                result = CommentService::Create.new.call(data)
                representer_response(result, CommentRepresenter)
            end

            routing.put do
                data = JsonRequestBody.parse_sym(routing.body.read)
                data[:username] = @auth_account.username
                result = CommentService::Edit.new.call(data)
                representer_response(result, CommentRepresenter)
            end

        end 
    end
    
end