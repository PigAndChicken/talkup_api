module TalkUp

    class Api < Roda
        
        route('comment') do |routing|

            routing.post do 
                data = JSON.parse routing.body.read
                
                result = CommentService::Create.new.call(data)
                representer_response(result, CommentRepresenter)
            end

        end 
    end
    
end