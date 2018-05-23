module TalkUp

    class Api < Roda
        
        route('feedback') do |routing|

            routing.post do 
                data = JsonRequestBody.parse_sym(routing.body.read) 
                
                result = FeedbackService::Create.new.call(data)
                representer_response(result, FeedbackRepresenter)
                
            end

        end 
    end
    
end