module TalkUp

    class Api < Roda
        
        route('comment') do |routing|

            routing.post do 
                data = JsonRequestBody.parse_sym(routing.body.read)
                
                result = CommentService::Create.new.call(data)
                representer_response(result, CommentRepresenter)
            end

        end 
    end
    
end